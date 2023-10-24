from allauth.account.adapter import DefaultAccountAdapter
from allauth.account.utils import user_field

class CustomAccountAdapter(DefaultAccountAdapter):
    def save_user(self, request, user, form, commit=False):
        data = form.cleaned_data
        user = super().save_user(request, user, form, commit)

        user_field(user, "google_id", data.get("google_id"))
        user_field(user, "nickname", data.get("nickname"))
        #user_field(user, "is_active", data.get("is_active"))
        #user_field(user, "is_superuser", data.get("is_superuser"))
        #user_field(user, "is_staff", data.get("is_staff"))

        user.save()
        return user