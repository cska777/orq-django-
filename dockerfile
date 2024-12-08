# Use an official Python runtime as a parent image
FROM python:3.12

# Set the working directory in the container
WORKDIR /app

# Install system dependencies (no need for MySQL client libraries anymore)
RUN apt-get update && apt-get install -y \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip
RUN pip install --upgrade pip

# Copy the requirements file into the container
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

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
