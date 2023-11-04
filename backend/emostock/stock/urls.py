from emostock.common.urls import viewset_path
from stock.views import StockView, MyStockView

urlpatterns = [
    viewset_path(StockView, "stock"),
    viewset_path(MyStockView, "mystock"),
]