from rest_framework.serializers import ModelSerializer
from .models import Emotion

class EmotionSerializer(ModelSerializer):
    class Meta:
        model = Emotion
        fields = '__all__'