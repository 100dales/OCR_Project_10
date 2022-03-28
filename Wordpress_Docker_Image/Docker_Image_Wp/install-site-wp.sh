#!/bin/sh

# Configuration du site Wordpress
wp core install --allow-root --path=/var/www/html --url=$1 --title=P10_Maîtrisez_votre_infra_cloud --admin_user=Dales --admin_password=100Dales! --admin_email=100dales.pro@gmail.com

# Configuration FR
wp language core install fr_FR
wp language core activate fr_FR

# Configuration du thème
wp theme activate twentytwenty

# Installation du plugin WP 
wp plugin install amazon-s3-and-cloudfront --allow-root --path=/var/www/html --activate

# Configuration du plugin S3

sed -i '133d' /var/www/html/wp-config.php
sed -i '128,130d' /var/www/html/wp-config.php

echo "define( 'AS3CF_SETTINGS', serialize( array(
    'provider' => 'aws',
    'access-key-id' => '$2',
    'secret-access-key' => '$3',
    'use-server-roles' => false,
    'bucket' => '$4',
    'region' => 'eu-west-3',
    'copy-to-s3' => true,
    'enable-object-prefix' => true,
    'object-prefix' => 'wp-content/uploads/',
    'use-yearmonth-folders' => true,
    'object-versioning' => true,
    // Delivery Provider ('storage', 'aws', 'do', 'gcp', 'cloudflare', 'keycdn', 'stackpath', 'other')
    'delivery-provider' => 'aws',
    'serve-from-s3' => true,
    // Use a custom domain (CNAME), not supported when using 'storage' Delivery Provider
    'enable-delivery-domain' => false,
    // Custom domain (CNAME), not supported when using 'storage' Delivery Provider
    'delivery-domain' => 'cdn.example.com',
    // Enable signed URLs for Delivery Provider that uses separate key pair (currently only 'aws' supported, a.k.a. CloudFront)
    'enable-signed-urls' => false,
    // Access Key ID for signed URLs (aws only, replace '*')
    'signed-urls-key-id' => '$2',
    // Key File Path for signed URLs (aws only, absolute file path, not URL)
    // Make sure hidden from public website, i.e. outside site's document root.
    'signed-urls-key-file-path' => '/path/to/key/file.pem',
    // Private Prefix for signed URLs (aws only, relative directory, no wildcards)
    'signed-urls-object-prefix' => 'private/',
    // Serve files over HTTPS
    'force-https' => false,
    // Remove the local file version once offloaded to bucket
    'remove-local-file' => false,
) ) );

" >> /var/www/html/wp-config.php

echo "if ( ! defined( 'ABSPATH' ) ) {
        define( 'ABSPATH', dirname( __FILE__ ) . '/' );
}" >> /var/www/html/wp-config.php

echo "require_once( ABSPATH . 'wp-settings.php' );" >> /var/www/html/wp-config.php