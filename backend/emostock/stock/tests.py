from django.urls import reverse
from rest_framework.test import APIClient
from rest_framework import status
from django.test import TestCase
from rest_framework.authtoken.models import Token

from stock.models import Stock, MyStock
from django.contrib.auth.models import User

class StockViewTestCase(TestCase):
    def setUp(self):
        self.client = APIClient()
        self.user = User.objects.create_user(username='testuser', password='testpassword')
        self.token = Token.objects.create(user=self.user)
        self.client.credentials(HTTP_AUTHORIZATION='Token ' + self.token.key)

        # Create a stock
        self.stock = Stock.objects.create(ticker='005930', name='삼성전자', price=150)

        # URL for StockView
        self.stock_list_url = reverse('stock-list')
        self.stock_detail_url = reverse('stock-detail', kwargs={'ticker': self.stock.ticker})

    # def test_get_stock_list(self):
    #     response = self.client.get(self.stock_list_url)
    #     self.assertEqual(response.status_code, status.HTTP_200_OK)
    #     self.assertEqual(len(response.data), 1)  # Assuming there is only one stock in test db

    def test_get_stock_detail(self):
        response = self.client.get(self.stock_detail_url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data['ticker'], self.stock.ticker)

class MyStockViewTestCase(TestCase):
    def setUp(self):
        self.client = APIClient()
        self.user = User.objects.create_user(username='testuser', password='testpassword')
        self.token = Token.objects.create(user=self.user)
        self.client.credentials(HTTP_AUTHORIZATION='Token ' + self.token.key)

        self.stock = Stock.objects.create(ticker='AAPL', name='Apple Inc.', price=150)
        self.mystock = MyStock.objects.create(user=self.user, stock=self.stock, quantity=10)

        # URL for MyStockView
        self.mystock_list_url = reverse('mystock-list')
        self.mystock_detail_url = reverse('mystock-detail', kwargs={'pk': self.stock.pk})

    # def test_get_mystock_list(self):
    #     response = self.client.get(self.mystock_list_url)
    #     self.assertEqual(response.status_code, status.HTTP_200_OK)
    #     self.assertEqual(len(response.data), 1)  # Assuming the user has only one MyStock

    def test_get_mystock_detail(self):
        response = self.client.get(self.mystock_detail_url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data[0]['stock'], self.stock.ticker)
        self.assertEqual(response.data[0]['quantity'], self.mystock.quantity)
