from django.core.validators import RegexValidator
from django.db import models

from emostock.common.model import BaseModel


class Stock(BaseModel):
    MARKET_TYPE = (
        ("KOSPI", "Korea Composite Stock Price Index"),
        ("KOSDAQ", "Korea Securities Dealers Automated Quotations"),
    )
    ticker = models.CharField(
        max_length=6,
        validators=[RegexValidator(r'^\d{6}$')],
        unique=True,
        primary_key=True,
    )

    name = models.CharField(default="")
    current_price = models.IntegerField(default=0)
    highest_price = models.IntegerField(default=0)
    lowest_price = models.IntegerField(default=0)
    market_type = models.CharField(choices=MARKET_TYPE, max_length=6)

    class Meta:
        verbose_name = "Stock"
        verbose_name_plural = "Stocks"
        ordering = ["ticker", ]


class MyStock(BaseModel):
    stock = models.ForeignKey(
        "stock.Stock", on_delete=models.CASCADE, related_name="my_stocks"
    )
    purchase_price = models.IntegerField(default=0)
    user = models.ForeignKey("user.User", on_delete=models.CASCADE, related_name="my_stocks")
    purchase_date = models.DateTimeField(auto_now_add=True)
    quantity = models.PositiveIntegerField(default=0)

    class Meta:
        verbose_name = "My_Stock"
        verbose_name_plural = "My_Stocks"
        ordering = ["stock", ]
