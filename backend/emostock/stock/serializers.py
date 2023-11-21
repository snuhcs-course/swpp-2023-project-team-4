from rest_framework import serializers

from emostock.common.enum_field import SerializerEnumCharField
from stock.models import Stock, MyStock


class StockSerializer(serializers.ModelSerializer):
    market_type = SerializerEnumCharField()

    class Meta:
        model = Stock
        fields = [
            "ticker",
            "name",
            "current_price",
            "closing_price",
            "fluctuation_rate",
            "market_type",
        ]


class MyStockSerializer(serializers.ModelSerializer):

    class Meta:
        model = MyStock
        fields = [
            "id",
            "stock",
            "price",
            "user",
            "transaction_type",
            "quantity",
        ]

class UserBalanceSerializer(serializers.Serializer):

    class Meta:
        fields = [
            "ticker",
            "quantity",
            "balance",
            "return",
        ]

