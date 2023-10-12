# Gunakan gambar PHP dengan Apache
FROM php:7.4-apache

# Install dependensi yang diperlukan
RUN apt-get update && apt-get install -y \
    libzip-dev \
    unzip \
    nodejs \
    npm

# Instal ekstensi PHP yang diperlukan
RUN docker-php-ext-install zip pdo pdo_mysql

# Aktifkan mod_rewrite untuk Apache
RUN a2enmod rewrite

# Salin kode proyek ke dalam kontainer
COPY . /var/www/html/

# Setel direktori kerja
WORKDIR /var/www/html

# Instal Composer (manajer dependensi PHP)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Instal dependensi proyek menggunakan Composer
RUN composer install

# Instal dependensi JavaScript
RUN npm install

# Kompilasi aset menggunakan npm
RUN npm run dev

# Expose port 80 (HTTP)
EXPOSE 80

# Perintah yang akan dijalankan ketika kontainer dijalankan
CMD ["apache2-foreground"]
