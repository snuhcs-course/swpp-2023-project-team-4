from django.urls import include, path

from . import views

urlpatterns = [
    path('<int:year>/<int:month>/', views.EmotionListView.as_view()),
    path('<int:year>/<int:month>/<int:day>/', views.EmotionUpdateView.as_view()),
    path('', views.EmotionListByRangeView.as_view())
]