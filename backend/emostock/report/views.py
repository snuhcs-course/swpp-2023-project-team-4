from rest_framework import viewsets, permissions
from rest_framework.response import Response

from report.models import Report
from report.serializers import ReportSerializer


class ReportView(viewsets.ModelViewSet):
    permission_classes = (permissions.IsAuthenticated,)
    queryset = Report.objects.all()
    serializer_class = ReportSerializer

    def list(self, request, *args, **kwargs):
        from stock.models import MyStock

        queryset = self.get_queryset()
        my_stocks = MyStock.quantity_not_zero(self.request.user)
        stocks_in_balance = list(my_stocks.keys())
        serialized_data = []
        for stock in stocks_in_balance:
            if queryset.filter(stock=stock).exists():
                tmp = queryset.filter(stock=stock).order_by("-date")[0]
                serialized_data.append(
                    {
                        "title": tmp.title,
                        "body": tmp.summary,
                    }
                )
        if len(serialized_data) == 0:
            for i in ('005930', '373220', '000660', '207940', '005490'):
                tmp = queryset.filter(stock=i).order_by("-date")[0]
                serialized_data.append(
                    {
                        "title": tmp.title,
                        "body": tmp.summary,
                    }
                )
        return Response(serialized_data)
