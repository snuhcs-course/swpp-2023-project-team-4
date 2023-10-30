from rest_framework import serializers

from stock.models import Stock


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