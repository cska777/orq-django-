# Utiliser une image Python officielle
FROM python:3.11-slim

# Définir le répertoire de travail
WORKDIR /app

# Installer les dépendances système nécessaires
RUN apt-get update && apt-get install -y \
    default-libmysqlclient-dev \
    libmariadb-dev \
    gcc \
    pkg-config \
    build-essential \
    libssl-dev \
    libffi-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


# Copier le fichier requirements.txt
COPY requirements.txt .

# Installer les dépendances Python
RUN pip install -r requirements.txt

# Copier le reste de l'application
COPY . .

# Commande à exécuter à l'intérieur du conteneur
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "orq_api_auth.wsgi:application"]
