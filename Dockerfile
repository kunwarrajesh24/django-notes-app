FROM python:3.9

# Set working directory
WORKDIR /app/backend

# Copy requirements first (for caching)
COPY requirements.txt /app/backend

# Install system dependencies
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install mysqlclient
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . /app/backend

# Expose Django port
EXPOSE 8000

# 🔥 MOST IMPORTANT LINE (THIS WAS MISSING)
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
