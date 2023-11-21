from rest_framework import viewsets, permissions

from report.models import ReportSummary
from report.serializers import ReportSummarySerializer


class ReportView(viewsets.ModelViewSet):
    permission_classes = (permissions.IsAuthenticated,)
    queryset = ReportSummary.objects.all()
    serializer_class = ReportSummarySerializer

