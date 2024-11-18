# Utiliser une image Python officielle 
FROM python:3.10  

# Définir le répertoire de travail 
WORKDIR /app  

# Installer les dépendances système nécessaires 
RUN apt-get update && apt-get install -y \
    mariadb-client \
    libmariadb-dev-compat \
    libmariadb-dev \
    gcc \
    pkg-config \
    build-essential \
    libssl-dev \
    libffi-dev \
    python3-dev \
    mysql-client \
    && rm -rf /var/lib/apt/lists/*

# Copier le fichier requirements.txt
COPY requirements.txt .

# Installer les dépendances Python 
RUN pip install --no-cache-dir -r requirements.txt

# Copier le reste de l'application
COPY . .

# Exécuter collectstatic APRÈS avoir installé les dépendances
RUN python manage.py collectstatic --noinput

# Variable d'environnement pour le port 
ENV PORT=8000

# Exposer le port pour l'application
EXPOSE 8000

# Commande à exécuter à l'intérieur du conteneur
CMD ["gunicorn", "--bind", "0.0.0.0:$PORT", "orq_api_auth.wsgi:application"]