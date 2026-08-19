# =============================================================
#  Sultan Cell - Docker Image
#  Multi-stage: build frontend, install vendor, lalu PHP+Apache
# =============================================================

# ---------- Stage 1: Build Frontend (React + Vite) ----------
FROM node:24-alpine AS frontend

WORKDIR /build

COPY frontend/package.json frontend/package-lock.json ./frontend/
RUN cd frontend && npm install --no-audit --no-fund

COPY frontend/ ./frontend/
RUN cd frontend && npm run build

# ---------- Stage 2: Install Composer Vendor ----------
FROM composer:2 AS vendor

WORKDIR /build
COPY backend/composer.json backend/composer.lock ./
RUN composer install \
        --no-dev \
        --no-scripts \
        --no-interaction \
        --prefer-dist \
        --optimize-autoloader

# ---------- Stage 3: PHP 8.2 + Apache ----------
FROM php:8.2-apache AS app

# Install dependensi sistem + ekstensi PHP yang dibutuhkan
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        curl \
        git \
        unzip \
        zip \
        libzip-dev \
        libpng-dev \
        libjpeg-dev \
        libfreetype6-dev \
        libicu-dev \
        libxml2-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j"$(nproc)" \
        gd \
        pdo \
        pdo_mysql \
        mysqli \
        bcmath \
        intl \
        zip \
        opcache \
    && a2enmod rewrite headers \
    && rm -rf /var/lib/apt/lists/*

# Salin konfigurasi Apache khusus Laravel
COPY docker/apache/000-default.conf /etc/apache2/sites-available/000-default.conf

# Salin kode aplikasi Laravel
WORKDIR /var/www/html
COPY backend/ /var/www/html/

# Gunakan vendor hasil install (bukan dari folder backend)
COPY --from=vendor /build/vendor /var/www/html/vendor

# Salin hasil build frontend ke public/app (frontend build menulis ke sini)
COPY --from=frontend /build/backend/public/app /var/www/html/public/app

# Salin entrypoint
COPY docker/php/entrypoint.sh /usr/local/bin/entrypoint.sh

EXPOSE 80

ENTRYPOINT ["sh", "/usr/local/bin/entrypoint.sh"]
CMD ["apache2-foreground"]