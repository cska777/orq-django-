FROM python:3.11

WORKDIR /app

# Installer les dépendances système
RUN apt-get update && apt-get install -y \
    default-libmysqlclient-dev \
    gcc \
    pkg-config \
    build-essential \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copier requirements et installer les dépendances Python
COPY requirements.txt .
RUN pip install --no-cache-dir mysqlclient==2.1.1 
RUN pip install --no-cache-dir -r requirements.txt

# Copier le reste de l'application
COPY . .

# Exécuter collectstatic
RUN python manage.py collectstatic --noinput

# Variable d'environnement pour le port
ENV PORT=8000

# Commande à exécuter
CMD ["gunicorn", "--bind", "0.0.0.0:${PORT}", "orq_api_auth.wsgi:application"]