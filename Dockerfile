# Use Python 3.9 base image
FROM python:3.9

# Set working directory
WORKDIR /app

# Copy requirements
COPY requirements.txt /app/

# Install system dependencies
RUN apt-get update \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy app code
COPY . /app/

# Expose port
EXPOSE 8000

# Use python3 explicitly
CMD ["sh", "-c", "python3 manage.py migrate && python3 manage.py runserver 0.0.0.0:8000"]
