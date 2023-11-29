from django.db import models
from emostock.common.model import BaseModel

class Report(BaseModel):

    title = models.CharField(max_length=100, default="")
    date = models.DateField()
    summary = models.TextField()
    stock = models.CharField(max_length=6)

    class Meta:
        verbose_name = "Report"
        verbose_name_plural = "Reports"
