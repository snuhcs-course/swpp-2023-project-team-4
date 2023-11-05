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
        "stock.Stock", on_delete=models.CASCADE, related_name="my_stocks"
    )
    price = models.IntegerField(default=0)
    user = models.ForeignKey("user.User", on_delete=models.CASCADE, related_name="my_stocks")
    purchase_date = models.DateTimeField(auto_now_add=True)
    quantity = models.PositiveIntegerField(default=0)
    transaction_type = build_enum_field(TransactionType, null=True, blank=True)

    class Meta:
        verbose_name = "My_Stock"
        verbose_name_plural = "My_Stocks"
        ordering = ["stock", ]
