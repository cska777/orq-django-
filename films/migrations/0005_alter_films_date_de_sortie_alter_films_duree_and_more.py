# Generated by Django 5.0.2 on 2024-02-25 20:56

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('films', '0004_alter_films_date_de_sortie_alter_films_duree_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='films',
            name='date_de_sortie',
            field=models.CharField(max_length=255),
        ),
        migrations.AlterField(
            model_name='films',
            name='duree',
            field=models.CharField(max_length=255),
        ),
        migrations.AlterField(
            model_name='films',
            name='genre_oeuvre',
            field=models.CharField(max_length=255),
        ),
        migrations.AlterField(
            model_name='films',
            name='press_score',
            field=models.CharField(max_length=255),
        ),
    ]
