from django.contrib.auth.backends import ModelBackend

from user.models import User

class CustomAuthBackend(ModelBackend):
    def authenticate(self, request, username, password):
        try:
            return User.objects.get(google_id=username)
        except User.DoesNotExist:
            return None

    def get_user(self, google_id):
        try:
            return User.objects.get(google_id=google_id)
        except User.DoesNotExist:
            return None