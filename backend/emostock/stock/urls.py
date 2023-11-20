from emostock.common.urls import viewset_path
from stock.views import StockView, MyStockView, UserBalanceView

urlpatterns = [
    viewset_path(StockView, "stock"),
    viewset_path(MyStockView, "mystock"),
    viewset_path(UserBalanceView, "balance"),
]