# Image Python officielle
FROM python:3.12

# Installer les dépendances système nécessaires
RUN apt-get update && apt-get install -y \
    default-libmysqlclient-dev \
    libmariadb-dev \
    libmariadb-dev-compat \
    pkg-config \
    gcc \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Définir le répertoire de travail
WORKDIR /app

# Upgrade pip
RUN pip install --upgrade pip

# Copier requirements
COPY requirements.txt .

# Variables d'environnement pour forcer la configuration MySQL
ENV MYSQLCLIENT_CFLAGS="-I/usr/include/mysql" \
    MYSQLCLIENT_LDFLAGS="-L/usr/lib/x86_64-linux-gnu -lmysqlclient"

# Installation avec configuration explicite
RUN pip install --no-cache-dir mysqlclient==2.2.1 \
    && pip install --no-cache-dir -r requirements.txt

# Copier le reste du projet
COPY . .

# Collecte des fichiers statiques
RUN python manage.py collectstatic --noinput

# Variable d'environnement pour le port
ENV PORT=8000

# Exposer le port
EXPOSE $PORT

# Commande de démarrage
CMD gunicorn --bind 0.0.0.0:$PORT orq_api_auth.wsgi:application