FROM php:8.2-apache

# Install required extensions
RUN docker-php-ext-install pdo pdo_mysql

# Enable Apache rewrite module
RUN a2enmod rewrite

# Set Apache configuration
RUN echo '<VirtualHost *:80>\n\
    ServerAdmin webmaster@localhost\n\
    DocumentRoot /var/www/html\n\
    \n\
    <Directory /var/www/html>\n\
        Options Indexes FollowSymLinks\n\
        AllowOverride All\n\
        Require all granted\n\
    </Directory>\n\
    \n\
    ErrorLog ${APACHE_LOG_DIR}/error.log\n\
    CustomLog ${APACHE_LOG_DIR}/access.log combined\n\
</VirtualHost>' > /etc/apache2/sites-available/000-default.conf

# Set working directory
WORKDIR /var/www/html

# Copy files with proper permissions
COPY --chown=www-data:www-data . .

# Ensure required files exist and have proper permissions
RUN touch users.json error.log && \
    chmod 666 users.json error.log && \
    chmod 755 /var/www/html && \
    [ -f index.php ] && chmod 644 index.php || true && \
    [ -f composer.json ] && chmod 644 composer.json || true

# Expose port
EXPOSE 80
