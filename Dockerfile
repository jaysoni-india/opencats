# Base image with Apache and PHP
FROM php:7.4-apache

# Install required PHP extensions
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    zip \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd \
    && docker-php-ext-install mysqli pdo pdo_mysql zip

# Enable Apache mod_rewrite for OpenCATS
RUN a2enmod rewrite

# Set the working directory
WORKDIR /var/www/html

# Clone the latest OpenCATS source
RUN apt-get install -y git && \
    git clone https://github.com/opencats/OpenCATS.git . && \
    chown -R www-data:www-data /var/www/html && \
    chmod -R 775 /var/www/html

# Expose the default web server port
EXPOSE 80
