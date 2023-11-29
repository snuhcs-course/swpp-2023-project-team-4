from rest_framework import serializers


class ReportSerializer(serializers.ModelSerializer):
    class Meta:
        fields = [
            "title",
            "body",
        ]
