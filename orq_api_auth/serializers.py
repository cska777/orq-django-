from rest_framework import serializers
from django.contrib.auth.models import User
from watchlist.models import Watchlist
from films.models import Films

class UserSerializer(serializers.ModelSerializer):
    class Meta(object):
        model = User
        fields = ['id', 'username', 'password', 'email']
        extra_kwargs = {
            "username" : { "required" : True },
            "password" : { "required" : True },
            "email" : { "required" : True }
        }


class WatchlistSerializer(serializers.ModelSerializer):
    class Meta(object):
        model = Watchlist
        fields = '__all__'

class FilmsSerializer(serializers.ModelSerializer): 
    class Meta(object):
        model = Films
        fields = '__all__'