import requests

from django.shortcuts import render
from django.urls import reverse
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.permissions import AllowAny, IsAuthenticated

from django.conf import settings
DUMMY_PW = getattr(settings, 'DUMMY_PW', None)


class SignInView(APIView):
    permission_classes = (IsAuthenticated,)
    
    def post(self, request):
        req_url = request.build_absolute_uri(reverse('signin').replace('signin/', 'dj-rest-auth/login/'))
        req_payload = {'google_id': request.data['google_id'], 'username': request.data['google_id'], 'password': DUMMY_PW}
        
        r = requests.post(req_url, data=req_payload)
        if r.status_code == 200:
            res_payload = {"access_token": r.json()['access'], "refresh_token": r.json()['refresh']}
            return Response(res_payload, status=200)
        else:
            res_payload = {"message": f"User with Google id '{request.data['google_id']}' doesn’t exist."}
            return Response(res_payload, status=401)


class SignUpView(APIView):
    permission_classes = (AllowAny,)

    def post(self, request):
        req_url = request.build_absolute_uri(reverse('signup').replace('signup/', 'dj-rest-auth/registration/'))
        data = request.data
        data.update({'username': request.data['google_id'], 'password1': DUMMY_PW, 'password2': DUMMY_PW})

        r = requests.post(req_url, data=data)
        if r.status_code == 201:
            res_payload = {"access_token": r.json()['access'], "refresh_token": r.json()['refresh']}
            return Response(res_payload, status=201)
        else:
            return Response(r.json(), status=400)


class SignOutView(APIView):
    permission_classes = (IsAuthenticated,)
    
    def post(self, request):
        req_url = request.build_absolute_uri(reverse('signout').replace('signout/', 'dj-rest-auth/logout/'))

        r = requests.post(req_url)
        if r.status_code == 200:
            return Response({"message: Signout Success"}, status=200)
        else:
            return Response(r.json(), status=401)
