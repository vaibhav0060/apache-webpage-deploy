#!/bin/bash
set -e

echo "🔧 Installing Apache (httpd)..."
sudo dnf update -y
sudo dnf install -y httpd

echo "🌐 Copying webpage files to Apache root..."
sudo cp -r /root/apache-webpage-deploy/webpage/* /var/www/html/

echo "🚀 Starting Apache web server..."
sudo systemctl enable httpd
sudo systemctl start httpd
sudo systemctl restart httpd

echo "✅ Apache is running and webpage is deployed!"

