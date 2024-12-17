from django.db import models
from django.contrib.auth.models import User 

from django.db.models.signals import post_save
from django.dispatch import receiver

class Watchlist(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    titre = models.CharField(max_length=255)
    illustration = models.CharField(max_length = 255, null = True)
    vu = models.BooleanField(default=False)
    mon_avis = models.TextField(max_length = 300, null=True)
    aime = models.BooleanField(default=False)
    en_cours = models.BooleanField(default=False)
    type = models.CharField(max_length = 255, default="")
    duree = models.IntegerField(default=0, null=True)
    nbSaison = models.IntegerField(default=0, null=True)
    date_sortie = models.IntegerField(default=0, null=True)
    synopsis = models.CharField(max_length = 3000, null = True)
    genres = models.CharField(max_length = 255, null=True)
    user_score = models.IntegerField(default = 0)
    note_utilisateur = models.IntegerField(default = 0)
    acteurs = models.CharField(max_length = 255, null=True)
    realisateurs = models.CharField(max_length = 255, null=True)
    
    class Meta:
        app_label = 'watchlist'


@receiver(post_save, sender=User)
def create_watchlist(sender,instance,created, **kwargs):
    if created:
        Watchlist.objects.create(user=instance)

