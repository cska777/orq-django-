from rest_framework import serializers
from django.contrib.auth.models import User
from watchlist.models import Watchlist

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
