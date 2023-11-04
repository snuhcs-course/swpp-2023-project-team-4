from rest_framework import serializers

from stock.models import Stock, MyStock


class StockSerializer(serializers.ModelSerializer):
    class Meta:
        model = Stock
        fields = [
            "ticker",
            "name",
            "current_price",
            "highest_price",
            "lowest_price",
            "market_type",
        ]


class MyStockSerializer(serializers.ModelSerializer):

    class Meta:
        model = MyStock
        fields = [
            "id",
            "stock",
            "purchase_price",
            "user",
            "purchase_date",
            "quantity",
        ]
