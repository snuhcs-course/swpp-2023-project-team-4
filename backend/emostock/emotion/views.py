from datetime import datetime

from django.shortcuts import render
from django.utils import timezone
from rest_framework import generics
from rest_framework.renderers import JSONRenderer
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated

from .models import Emotion
from .serializers import EmotionSerializer
from user.models import User


class EmotionListJSONRenderer(JSONRenderer):
    def render(self, data, accepted_media_type=None, renderer_context=None):
        res_payload = {'emotions': []}
        for emotion in data:
            day = datetime.strptime(emotion['date'], "%Y-%m-%d").day
            res_payload['emotions'].append({'date': day, 'emotion': emotion['value'], 'text': emotion['text']})
        return super(EmotionListJSONRenderer, self).render(res_payload, accepted_media_type, renderer_context)

class EmotionListView(generics.ListAPIView):
    permission_classes = (IsAuthenticated,)
    serializer_class = EmotionSerializer
    renderer_classes = (EmotionListJSONRenderer, )
    
    def get_queryset(self):
        google_id = self.kwargs['google_id']
        year = self.kwargs['year']
        month = self.kwargs['month']

        try:
            return Emotion.objects.filter_by_user_and_month(google_id, year, month).order_by('date')
        except User.DoesNotExist:
            pass
