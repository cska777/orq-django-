from django.contrib import admin
from django.urls import path
from . import views
import orq_api_auth.tasks

urlpatterns = [
    path('login/', views.login, name='login'),
    path('signup/', views.signup, name='signup'),
    path('test_token/', views.test_token, name='test_token'),
    path('watchlist/', views.watchlist, name='watchlist'),
    path('watchlist/<int:oeuvre_id>/', views.watchlist_update, name='watchlist_update'),
    path('films/', views.films, name='films'),
    path('change_password/', views.change_password, name='change_password'),
    path('user/auth/', views.user_auth, name='user_auth'),
    path('<int:oeuvre_id>/note_entree_watchlist/', views.note_entree_watchlist, name="note_entree_watchlist")
]
