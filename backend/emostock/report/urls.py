from emostock.common.urls import viewset_path
from report.views import ReportView

urlpatterns = [
    viewset_path(ReportView, "report"),
]