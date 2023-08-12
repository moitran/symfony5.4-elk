# Use the official PHP image
FROM php:8.2-fpm

# Set working directory
WORKDIR /var/www/html

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libpq-dev \
    unzip \
    && docker-php-ext-install pdo pdo_pgsql

# Install Composer
COPY --from=composer:2.1 /usr/bin/composer /usr/bin/composer

# Copy Symfony app files
COPY . /var/www/html/

# Install Symfony dependencies
RUN composer install --no-interaction

EXPOSE 9000
CMD ["php-fpm"]
