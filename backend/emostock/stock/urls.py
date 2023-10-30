from emostock.common.urls import viewset_path
from stock.views import StockView

urlpatterns = [
    viewset_path(StockView, "stock"),
]