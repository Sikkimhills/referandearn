FROM php:8.2-apache

# Install extensions
RUN docker-php-ext-install pdo pdo_mysql

# Enable Apache modules
RUN a2enmod rewrite

# Set working directory
WORKDIR /var/www/html

# Copy files with proper permissions
COPY --chown=www-data:www-data . .

# Ensure required files exist and have proper permissions
RUN touch users.json error.log && \
    chmod 666 users.json error.log && \
    chmod 755 /var/www/html && \
    chmod 644 index.php composer.json

# Apache configuration
COPY ./000-default.conf /etc/apache2/sites-available/000-default.conf

# Expose port
EXPOSE 80
