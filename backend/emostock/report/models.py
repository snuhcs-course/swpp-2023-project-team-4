from django.db import models
from emostock.common.model import BaseModel

class Report(BaseModel):

    date = models.DateField()
    summary = models.TextField()
    stock = models.CharField(max_length=6)

    class Meta:
        verbose_name = "Report_Summary"
        verbose_name_plural = "Report_Summaries"
        ordering = ["date", ]


