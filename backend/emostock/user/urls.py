from django.urls import include, path

from . import views

urlpatterns = [
    path('dj-rest-auth/', include('dj_rest_auth.urls')),
    path('dj-rest-auth/registration/', include('dj_rest_auth.registration.urls')),
    path('account/', include('allauth.urls')),
    path('signup/', views.SignUpView.as_view(), name='signup'),
]