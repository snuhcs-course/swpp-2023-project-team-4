from django.db import models

from emostock.common.model import BaseModel


class ReportAnalysis(BaseModel):

    company = models.CharField(max_length=50)
    date = models.DateField()
    link = models.CharField(max_length=200)
    author = models.CharField(max_length=50)
    source = models.CharField(max_length=50)
    title = models.TextField()
    fair_price = models.IntegerField()
    investment_op = models.CharField(max_length=50)
    status = models.CharField(max_length=50)
    content = models.TextField()
    stock = models.ForeignKey(
        "stock.Stock", on_delete=models.CASCADE, related_name="report_analysis"
    )

    class Meta:
        verbose_name = "Report_Analysis"
        verbose_name_plural = "Report_Analyses"
        ordering = ["company", ]

class ReportSummary(BaseModel):

    date = models.DateField()
    summary = models.TextField()
    stock = models.ForeignKey(
        "stock.Stock", on_delete=models.CASCADE, related_name="report_summary"
    )

    class Meta:
        verbose_name = "Report_Summary"
        verbose_name_plural = "Report_Summaries"
        ordering = ["date", ]


