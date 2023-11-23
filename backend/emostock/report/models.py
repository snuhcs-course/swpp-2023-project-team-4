from django.db import models
from emostock.common.model import BaseModel

class Report(BaseModel):

    date = models.DateField()
    summary = models.TextField()
    stock = models.ForeignKey(
        "stock.Stock", on_delete=models.CASCADE, related_name="report_summary"
    )

    class Meta:
        verbose_name = "Report_Summary"
        verbose_name_plural = "Report_Summaries"
        ordering = ["date", ]


