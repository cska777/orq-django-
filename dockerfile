FROM python:3.11-slim

WORKDIR /app

# Installer les dépendances système
RUN apt-get update && apt-get install -y \
    default-libmysqlclient-dev \
    gcc \
    pkg-config \
    build-essential \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copier requirements et installer les dépendances
COPY requirements.txt .
RUN pip install --no-cache-dir mysqlclient==2.1.1
RUN pip install --no-cache-dir -r requirements.txt

# Copier l'application
COPY . .

# Collectstatic
RUN python manage.py collectstatic --noinput

# Port et commande
ENV PORT=8000
CMD gunicorn --bind 0.0.0.0:$PORT orq_api_auth.wsgi:application