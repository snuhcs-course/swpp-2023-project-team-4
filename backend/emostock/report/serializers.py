from rest_framework import serializers
from report.models import ReportSummary


class ReportSummarySerializer(serializers.ModelSerializer):
    class Meta:
        model = ReportSummary
        fields = [
            "date",
            "summary",
            "stock",
        ]
