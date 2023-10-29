from rest_framework import exceptions, serializers
from dj_rest_auth.registration.serializers import RegisterSerializer
from dj_rest_auth.serializers import LoginSerializer
from django.utils.translation import gettext_lazy as _


class CustomRegisterSerializer(RegisterSerializer):
    password1 = None
    password2 = None
    google_id = serializers.CharField()
    nickname = serializers.CharField()
    #is_active = serializers.BooleanField()
    #is_superuser = serializers.BooleanField()
    #is_staff = serializers.BooleanField()

    def validate(self, data):
        return data

    def get_cleaned_data(self):
        data = {}

        data['google_id'] = self.validated_data.get('google_id', '')
        data['nickname'] = self.validated_data.get('nickname', '')
        #data['is_active'] = self.data.get('is_active', '')
        #data['is_superuser'] = self.data.get('is_superuser', '')
        #data['is_staff'] = self.data.get('is_staff', '')

        return data

class CustomLoginSerializer(LoginSerializer):
    password = None

    def _validate_username(self, username, password):
        if username:
            user = self.authenticate(username=username, password=password)
        else:
            msg = _('Must include "username".')
            raise exceptions.ValidationError(msg)

        return user