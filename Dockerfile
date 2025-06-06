# استخدم صورة PHP مع دعم FPM
FROM php:8.2-fpm

# تثبيت الامتدادات المطلوبة
RUN docker-php-ext-install pdo pdo_mysql

# تثبيت Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# تعيين مجلد العمل
WORKDIR /var/www/html

# نسخ الملفات إلى الحاوية
COPY . .

# تثبيت الاعتماديات
RUN composer install --no-dev --optimize-autoloader

# تعيين الأذونات
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# تعيين نقطة الدخول
CMD ["php-fpm"]
