FROM python:3.12

WORKDIR /app

# Installer les dépendances système nécessaires
RUN apt-get update && apt-get install -y \
    default-libmysqlclient-dev \
    libmariadb-dev \
    libmariadb-dev-compat \
    pkg-config \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Configurer pkg-config manuellement
ENV MYSQLCLIENT_CFLAGS=-I/usr/include/mysql
ENV MYSQLCLIENT_LDFLAGS=-L/usr/lib/x86_64-linux-gnu -lmysqlclient

# Mettre à jour pip
RUN pip install --upgrade pip

# Installer mysqlclient séparément
RUN pip install --no-cache-dir --no-binary mysqlclient mysqlclient==2.2.1

# Copier les fichiers de dépendances
COPY requirements.txt .

# Installer les autres dépendances
RUN pip install --no-cache-dir -r requirements.txt

# Copier le reste de l'application
COPY . .

# Exécuter collectstatic pour Django
RUN python manage.py collectstatic --noinput

# Définir le port
ENV PORT=8000

# Exposer le port
EXPOSE $PORT

# Commande pour démarrer le serveur
CMD gunicorn --bind 0.0.0.0:$PORT orq_api_auth.wsgi:application
