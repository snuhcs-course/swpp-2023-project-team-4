from django.db import models


class TimestampModel(models.Model):
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        abstract = True

    @property
    def is_modified(self):
        return self.updated_at > self.created_at


class BaseModel(TimestampModel, models.Model):

    class Meta:
        abstract = True