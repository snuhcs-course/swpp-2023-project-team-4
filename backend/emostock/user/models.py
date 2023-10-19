from django.contrib.auth.base_user import AbstractBaseUser
from django.contrib.auth.models import PermissionsMixin
from django.db import models

from .managers import UserManager

class User(AbstractBaseUser, PermissionsMixin):
    google_id = models.CharField(max_length=50, unique=True)
    nickname = models.CharField(max_length=20)
    is_active = models.BooleanField(default=True)
    is_superuser = models.BooleanField(default=False)
    is_staff = models.BooleanField(default=False)

    email = None
    username = None

    USERNAME_FIELD = 'google_id'

    REQUIRED_FIELDS = [
        'nickname'
    ]

    objects = UserManager()

    def __str__(self):
        return self.google_id
    
    def get_nickname(self):
        return self.nickname    

