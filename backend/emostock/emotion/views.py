from datetime import date, datetime, timedelta

from django.core.exceptions import ValidationError
from django.shortcuts import render
from django.utils import timezone
from rest_framework import generics
from rest_framework.renderers import JSONRenderer
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from rest_framework.views import APIView

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


class DateNotValid(Exception):
    pass

class EmotionUpdateView(APIView):
    permission_classes = (IsAuthenticated,)
    serializer_class = EmotionSerializer

    def check_date(self, target_year, target_month, target_day):
        today = timezone.localdate()
        monday = today - timedelta(days=today.weekday())

        target_date = date(target_year, target_month, target_day)

        if (target_date < monday) or (target_date > today):
            raise DateNotValid()
        else:
            return target_date

    def get_queryset(self):
        google_id = self.kwargs['google_id']
        year = self.kwargs['year']
        month = self.kwargs['month']
        day = self.kwargs['day']

        return Emotion.objects.filter_by_user_and_month(google_id, year, month).filter(date__day=day)
    
    def put(self, request, *args, **kwargs):
        try:
            target_date = self.check_date(kwargs['year'], kwargs['month'], kwargs['day'])
        except DateNotValid:
            res_payload = {"message": "Not allowed to modify emotions from before this week or future"}
            return Response(res_payload, status=405)
        
        try:
            target_emotion_list = self.get_queryset()
        except User.DoesNotExist:
            res_payload = {"message": f"User with Google id '{kwargs['google_id']}' doesn’t exist."}
            return Response(res_payload, status=404)
        
        try:
            if target_emotion_list:
                emotion = target_emotion_list[0]
                emotion.value = request.data['emotion']
                emotion.text = request.data['text']
                emotion.full_clean()
                emotion.save()
            else:
                emotion = Emotion(date=target_date, value=request.data['emotion'], text=request.data['text'])
                emotion.full_clean()
                emotion.save()
                emotion.user.add(User.objects.get(google_id=kwargs['google_id']))
        except ValidationError:
            res_payload = {"message": "The Emotion value must be an integer between -2 and 2."}
            return Response(res_payload, status=400)
            
        res_payload = {"message": "Record Success"}
        return Response(res_payload, status=200)
