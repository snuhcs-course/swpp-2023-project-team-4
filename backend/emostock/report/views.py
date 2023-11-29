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
            serialized_data.append(
                {
                    "title": "시가총액 TOP 5",
                    "body": "1. 삼성전자 \n 2. LG에너지솔루션 \n 3. SK하이닉스 \n 4. 삼성바이오로직스 \n 5. 삼성전자우",
                }
            )
        return Response(serialized_data)
