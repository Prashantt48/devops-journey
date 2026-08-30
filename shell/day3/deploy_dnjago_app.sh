#!/bin/bash

# Deploy Django application and handle errors

set -e

code_clone() {
    echo "Cloning the Django app..."

    if [ -d "django-notes-app" ]; then
        echo "Django app directory already exists."
        cd django-notes-app
    else
        git clone https://github.com/LondheShubham153/django-notes-app.git
        cd django-notes-app
    fi
}

installation_requirement() {
    echo "Installing dependencies..."

    sudo apt-get update
    sudo apt-get install docker.io nginx -y
}

required_restart() {
    echo "Starting Docker and Nginx..."

    sudo systemctl enable --now docker
    sudo systemctl enable --now nginx
}

deploy() {
    echo "Building Docker image..."

    sudo docker build -t notes-app .

    echo "Starting Docker container..."

    sudo docker run -d -p 8000:8000 --name notes-app notes-app:latest
}

echo "************** Deployment Started **************"

code_clone
installation_requirement
required_restart
deploy

echo "************** Deployment Done *****************"
