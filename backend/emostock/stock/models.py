from django.core.validators import RegexValidator
from django.db import models

from emostock.common.enum_field import build_enum_field
from emostock.common.enums import MarketType, TransactionType
from emostock.common.model import BaseModel


class Stock(BaseModel):
    ticker = models.CharField(
        max_length=6,
        validators=[RegexValidator(r'^\d{6}$')],
        unique=True,
        primary_key=True,
    )

    name = models.CharField(default="")
    current_price = models.IntegerField(default=0)
    closing_price = models.IntegerField(default=0)
    fluctuation_rate = models.FloatField(default=0)
    market_type = build_enum_field(MarketType)

    class Meta:
        verbose_name = "Stock"
        verbose_name_plural = "Stocks"
        ordering = ["ticker", ]


class MyStock(BaseModel):
    stock = models.ForeignKey(
        "stock.Stock",  on_delete=models.CASCADE, related_name="my_stocks"
    )
    price = models.IntegerField(default=0)
    user = models.ForeignKey("user.User", on_delete=models.CASCADE, related_name="my_stocks")
    purchase_date = models.DateField(auto_now_add=True)
    quantity = models.PositiveIntegerField(default=0)
    transaction_type = build_enum_field(TransactionType, null=True, blank=True)

    class Meta:
        verbose_name = "My_Stock"
        verbose_name_plural = "My_Stocks"
        ordering = ["stock", ]

    @classmethod
    def calculate_balance(cls, user):
        my_stocks = MyStock.objects.filter(user=user)
        quantity = {}
        total = {}
        for my_stock in my_stocks:
            if my_stock.stock.ticker in quantity:
                if my_stock.transaction_type == TransactionType.BUY:
                    quantity[my_stock.stock.ticker] += my_stock.quantity
                    total[my_stock.stock.ticker] += my_stock.quantity * my_stock.price
                else:
                    quantity[my_stock.stock.ticker] -= my_stock.quantity
                    total[my_stock.stock.ticker] -= my_stock.quantity * my_stock.price
                    if quantity[my_stock.stock.ticker] == 0:
                        del quantity[my_stock.stock.ticker]
                        del total[my_stock.stock.ticker]
            else:
                quantity[my_stock.stock.ticker] = my_stock.quantity
                total[my_stock.stock.ticker] = my_stock.quantity * my_stock.price

        return quantity, total

    @classmethod
    def quantity_not_zero(cls, user):
        my_stocks = MyStock.objects.filter(user=user)
        quantity = {}
        for my_stock in my_stocks:
            if my_stock.stock.ticker in quantity:
                if my_stock.transaction_type == TransactionType.BUY:
                    quantity[my_stock.stock.ticker] += my_stock.quantity
                else:
                    quantity[my_stock.stock.ticker] -= my_stock.quantity
                    if quantity[my_stock.stock.ticker] <= 0:
                        del quantity[my_stock.stock.ticker]
            else:
                quantity[my_stock.stock.ticker] = my_stock.quantity

        return quantity

    @classmethod
    def calculate_return(cls, user, sdate, edate):
        from emotion.models import Emotion
        from datetime import timedelta, datetime

        def get_or_set_value(d, key, value):
            if key in d:
                original_value = d[key]
                updated_value = (original_value[0] + value[0], original_value[1] + value[1])
                d[key] = updated_value
            else:
                d[key] = value

        def calculate_price(my_stocks):
            net_price = 0
            total_price = 0
            for my_stock in my_stocks:
                if my_stock.transaction_type == TransactionType.BUY:
                    end_price = Stock.objects.filter(ticker=my_stock.stock.ticker)[0].closing_price
                    quantity = my_stock.quantity
                    net_price += end_price * quantity - my_stock.price * quantity
                    total_price += my_stock.price * quantity

            return net_price, total_price

        sdate = datetime.strptime(sdate, "%Y-%m-%d")
        edate = datetime.strptime(edate, "%Y-%m-%d")
        emotions = Emotion.objects.filter(user=user, date__range=[sdate, edate])
        my_stocks = MyStock.objects.filter(user=user, purchase_date__range=[sdate, edate])
        return_rate = {}
        for date in (sdate + timedelta(n) for n in range(5)):
            emotion = emotions.filter(date=date)
            my_stock = my_stocks.filter(purchase_date=date)
            if emotion:
                emotion = emotion[0].value
                value = calculate_price(my_stock)
                get_or_set_value(return_rate, emotion, value)
        return return_rate
