from django.urls import path
from . import views
from django.contrib.auth import views as auth_views

urlpatterns = [
    path('login/', views.login, name='login'),
    path('signup/', views.signup, name='signup'),
    path('test_token/', views.test_token, name='test_token'),
    path('watchlist/', views.watchlist, name='watchlist'),
    path('watchlist/<int:oeuvre_id>/', views.watchlist_update, name='watchlist_update'),
    path('change_password/', views.change_password, name='change_password'),
    path('user/auth/', views.user_auth, name='user_auth'),

    # Réinitialisation du mot de passe
    path("password_reset/", auth_views.PasswordResetView.as_view(), name="password_reset"),
    path("password_reset_done", auth_views.PasswordResetDoneView.as_view(), name="password_reset_done"),
    path("reset/<uidb64>/<token>/", auth_views.PasswordResetConfirmView.as_view(), name="password_reset_confirm"),
    path("reset_done/", auth_views.PasswordResetCompleteView.as_view(), name="paswword_reset_complete")
]
