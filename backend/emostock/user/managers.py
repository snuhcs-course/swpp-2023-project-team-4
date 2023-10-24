from django.contrib.auth.base_user import BaseUserManager
from django.conf import settings

class UserManager(BaseUserManager):
    def create_user(self, google_id, nickname, **extra_fields):
        if google_id is None:
            raise ValueError('A User must have a google Id.')
        if nickname is None:
            raise ValueError('A User must have a username.')
        
        user = self.model(
            google_id = google_id,
            nickname = nickname,
            **extra_fields
        )

        user.set_password(getattr(settings, 'DUMMY_PW', None))
        user.save()

        return user
    
    def create_superuser(self, google_id, nickname):        
        user = self.create_user(google_id, nickname)
        
        user.is_superuser = True    # Not working
        user.is_staff = True        # Not working
        user.save()
        
        return user