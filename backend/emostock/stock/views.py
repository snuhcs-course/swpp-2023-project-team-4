from rest_framework import viewsets, permissions, status
from rest_framework.response import Response

from stock.models import Stock, MyStock
from stock.serializers import StockSerializer, MyStockSerializer


class StockView(viewsets.ModelViewSet):
    permission_classes = (permissions.IsAuthenticated,)
    queryset = Stock.objects.all().order_by("ticker")
    serializer_class = StockSerializer
    lookup_field = "ticker"


class MyStockView(viewsets.ModelViewSet):
    permission_classes = (permissions.IsAuthenticated,)
    serializer_class = MyStockSerializer

    def get_queryset(self):
        return MyStock.objects.filter(user=self.request.user)

    def retrieve(self, request, *args, **kwargs):
        qs = self.filter_queryset(self.get_queryset())
        mystock = qs.filter(stock=kwargs["pk"])
        if len(mystock) == 0:
            return Response(status=status.HTTP_404_NOT_FOUND)
        else:
            serialized_data = [self.get_serializer(item).data for item in mystock]
            return Response(serialized_data)
