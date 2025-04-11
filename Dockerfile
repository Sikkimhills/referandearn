# Use official PHP image with Apache
FROM php:8.2-apache

# Install required extensions
RUN docker-php-ext-install pdo pdo_mysql

# Enable Apache rewrite module
RUN a2enmod rewrite

# Set working directory
WORKDIR /var/www/html

# Copy files to container
COPY . .

# Set proper permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod 755 /var/www/html \
    && [ -f index.php ] && chmod 644 index.php || true \
    && [ -f composer.json ] && chmod 644 composer.json || true \
    && touch users.json error.log \
    && chmod 666 users.json error.log

# Expose port 80
EXPOSE 80
