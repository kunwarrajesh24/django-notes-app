FROM python:3.9

# Set correct working directory (IMPORTANT FIX)
WORKDIR /app

# Copy requirements first (for caching)
COPY requirements.txt /app/

# Install system dependencies
RUN apt-get update \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install mysqlclient
RUN pip install --no-cache-dir -r requirements.txt

# Copy full project (including manage.py & db.sqlite3)
COPY . /app/

# Expose Django port
EXPOSE 8000

# 🔥 Auto migrate + run server (BEST PRACTICE)
CMD ["sh", "-c", "python manage.py migrate && python manage.py runserver 0.0.0.0:8000"]
