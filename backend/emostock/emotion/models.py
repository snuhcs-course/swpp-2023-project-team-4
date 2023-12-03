from django.core.validators import MinValueValidator, MaxValueValidator
from django.db import models

from user.models import User

class UserEmotionQuerySet(models.query.QuerySet):
    def filter_by_user_and_month(self, user, year, month):
        return self.filter(user=user, date__year=year, date__month=month)
    
    def filter_by_user_and_date(self, user, start, end):
        return self.filter(user=user, date__gte=start, date_lte=end)

class Emotion(models.Model):
    user = models.ManyToManyField('user.User')
    date = models.DateField()
    value = models.IntegerField(validators=[MinValueValidator(-2), MaxValueValidator(2)])
    text = models.CharField(max_length=50, blank=True)

    objects = UserEmotionQuerySet.as_manager()

    def __str__(self):
        return f"id: {self.id}, value: {self.value}"
    
    def get_value(self):
        return self.value
