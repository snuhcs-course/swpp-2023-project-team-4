import json

from rest_framework import viewsets, permissions, status
from rest_framework.response import Response
from rest_framework.decorators import action

from stock.models import Stock, MyStock
from stock.serializers import StockSerializer, MyStockSerializer, UserBalanceSerializer


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


    def list(self, request, *args, **kwargs):
        qs = self.filter_queryset(self.get_queryset())
        if self.request.query_params:
            if "year" in self.request.query_params:
                year = self.request.query_params["year"]
                qs = qs.filter(purchase_date__year=year)
            if "month" in self.request.query_params:
                month = self.request.query_params["month"]
                qs = qs.filter(purchase_date__month=month)
            if "day" in self.request.query_params:
                day = self.request.query_params["day"]
                qs = qs.filter(purchase_date__day=day)
        serialized_data = [self.get_serializer(item).data for item in qs]
        return Response(serialized_data)


class UserBalanceView(viewsets.ModelViewSet):
    permission_classes = (permissions.IsAuthenticated,)
    serializer_class = UserBalanceSerializer

    def get_queryset(self):
        return MyStock.objects.filter(user=self.request.user)

    def list(self, request, *args, **kwargs):
        quantity, total = MyStock.calculate_balance(self.request.user)
        serialized_data = []
        for key in quantity.keys():
            serialized_data.append(
                {
                    "ticker": key,
                    "quantity": quantity[key],
                    "balance": total[key],
                    "return": quantity[key] * Stock.objects.get(ticker=key).current_price - total[key],
                }
            )
        return Response(serialized_data)

    @action(detail=False, methods=["get"])
    def validate_quantity(self, request, *args, **kwargs):
        is_valid = False
        try:
            json_data = json.loads(self.request.body)
        except json.JSONDecodeError as e:
            return Response(status=status.HTTP_400_BAD_REQUEST)
        if "ticker" not in json_data:
            return Response(status=status.HTTP_400_BAD_REQUEST)
        ticker = json_data["ticker"]
        if "quantity" not in json_data:
            return Response(status=status.HTTP_400_BAD_REQUEST)
        quantity = json_data["quantity"]
        if not quantity.isdigit():
            return Response(status=status.HTTP_400_BAD_REQUEST)
        # ticker validate도 해주기
        quantity = int(quantity)
        dict_quantity, _ = MyStock.calculate_balance(self.request.user)
        current_quantity = dict_quantity.get(ticker, 0)
        if quantity > current_quantity:
            return Response(is_valid)
        else:
            is_valid = True
            return Response(is_valid)

    @action(detail=False, methods=["get"])
    def return_rate(self, request, *args, **kwargs):
        serialized_data = []
        try:
            if "sdate" in self.request.query_params:
                sdate = self.request.query_params["sdate"]
            if "edate" in self.request.query_params:
                edate = self.request.query_params["edate"]
            if sdate and edate:
                result = MyStock.calculate_return(self.request.user, sdate, edate)
                for k, v in result.items():
                    if v[1] == 0:
                        continue
                    serialized_data.append(
                        {
                            "emotion": k,
                            "net_price": v[0],
                            "total_price": v[1],
                            "return_rate": round(v[0] / v[1] * 100, 2)
                        }
                    )
                return Response(serialized_data)
        except Exception as e:
            return Response(status=status.HTTP_400_BAD_REQUEST)