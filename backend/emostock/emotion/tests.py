from django.test import TestCase

# Create your tests here.

from django.test import TestCase
from django.urls import reverse
from rest_framework.test import APIClient
from rest_framework import status
from your_app_name.models import Emotion, User

class EmotionViewTestCase(TestCase):
    def setUp(self):
        self.client = APIClient()

        # 유저 그냥 만들기 
        self.user = User.objects.create_user(nickname='Jessica', password='12345')
        self.client.force_authenticate(user=self.user)

        # 감정 생성
        Emotion.objects.create(user=self.user, date='2023-01-01', value=1, text='Happy')
        Emotion.objects.create(user=self.user, date='2023-01-02', value=-1, text='Sad')


        self.url_list = reverse('emotion_list', kwargs={'year': 2023, 'month': 1})


        self.url_update = reverse('emotion_update', kwargs={'year': 2023, 'month': 1, 'day': 1})

    def test_get_emotion_list(self):
        response = self.client.get(self.url_list)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(len(response.data['emotions']), 2)


    def test_update_emotion(self):
        update_data = {'emotion': 2, 'text': 'Very Happy'}
        response = self.client.put(self.url_update, update_data, format='json')
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(Emotion.objects.get(date='2023-01-01').value, 2)

    def test_delete_emotion(self):
        response = self.client.delete(self.url_update)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertFalse(Emotion.objects.filter(date='2023-01-01').exists())

