from rest_framework import viewsets, permissions

from report.models import Report
from report.serializers import ReportSerializer


class ReportView(viewsets.ModelViewSet):
    permission_classes = (permissions.IsAuthenticated,)
    queryset = Report.objects.all()
    serializer_class = ReportSerializer

