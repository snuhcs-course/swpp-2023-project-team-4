from rest_framework import viewsets, permissions

from stock.models import Stock
from stock.serializers import StockSerializer


class StockView(viewsets.ModelViewSet):
    permission_classes = (permissions.IsAuthenticated,)
    queryset = Stock.objects.all().order_by("ticker")
    serializer_class = StockSerializer
    lookup_field = "ticker"