from rest_framework import serializers
from dj_rest_auth.registration.serializers import RegisterSerializer

class CustomRegisterSerializer(RegisterSerializer):
    google_id = serializers.CharField()
    nickname = serializers.CharField()
    #is_active = serializers.BooleanField()
    #is_superuser = serializers.BooleanField()
    #is_staff = serializers.BooleanField()

    def get_cleaned_data(self):
        data = super().get_cleaned_data()

        data['google_id'] = self.validated_data.get('google_id', '')
        data['nickname'] = self.validated_data.get('nickname', '')
        #data['is_active'] = self.data.get('is_active', '')
        #data['is_superuser'] = self.data.get('is_superuser', '')
        #data['is_staff'] = self.data.get('is_staff', '')

        return data
    