from django.urls import include, path

from . import views

urlpatterns = [
    path('dj-rest-auth/', include('dj_rest_auth.urls')),
    path('dj-rest-auth/registration/', include('dj_rest_auth.registration.urls')),
    path('account/', include('allauth.urls')),
    path('signin/', views.SignInView.as_view(), name='signin'),
    path('signup/', views.SignUpView.as_view(), name='signup'),
    path('signout/', views.SignOutView.as_view(), name='signout'),
    path('verify/', views.UserInfoView.as_view(), name='verify'),
]