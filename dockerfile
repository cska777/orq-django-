# Use an official Python runtime as a parent image
FROM python:3.12

# Set the working directory in the container
WORKDIR /app

# Install system dependencies for MySQL and Python compilation
RUN apt-get update && apt-get install -y \
    default-libmysqlclient-dev \
    libmariadb-dev \
    libmariadb-dev-compat \
    pkg-config \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip
RUN pip install --upgrade pip

# Copy the requirements file into the container
COPY requirements.txt .

# VARIABLES D'ENVIRONEMENT pour spécifier les flags manuellement
ENV MYSQLCLIENT_CFLAGS="-I/usr/include/mariadb -I/usr/include/mariadb/mysql"
ENV MYSQLCLIENT_LDFLAGS="-L/usr/lib/aarch64-linux-gnu/ -lmariadb"

# Install Python dependencies
RUN pip install --no-cache-dir --no-binary :all: mysqlclient==2.2.1 \
    && pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Run collectstatic after installing dependencies
RUN python manage.py collectstatic --noinput

# Set environment variable for the port
ENV PORT=8000

# Expose the port the app runs on
EXPOSE $PORT

# Use gunicorn to serve the application
CMD gunicorn --bind 0.0.0.0:$PORT orq_api_auth.wsgi:application
