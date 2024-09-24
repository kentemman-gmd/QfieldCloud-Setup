# QFieldCloud Setup Script

This repository contains a shell script to automate the setup process for QFieldCloud, including installing Docker, pulling the repository, and configuring the environment.

## Prerequisites

- Ubuntu or Debian-based system
- `wget` installed

## Installation and Setup

Follow these steps to install and set up QFieldCloud using this script.

### Step 1: Download the Setup Script

Use the following `wget` command to download the script:

```bash
wget https://raw.githubusercontent.com/kentemman-gmd/QfieldCloud-Setup/refs/heads/main/setup.sh -O setup.sh
```

## Step 4: Build and start Docker containers
```bash
sudo docker compose up -d --build
```
## Step 5: Run database migrations
```bash
sudo docker compose exec app python manage.py migrate
```
## Step 6: Collect static files
```bash
sudo docker compose run app python manage.py collectstatic --noinput
```
## Step 7: Check app status
```bash
sudo docker compose exec app python manage.py status
```
## Step 8: Create superuser
```bash
sudo docker compose run app python manage.py createsuperuser --username kentemman --email super@user.com
```
