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
### Step 2: Edit the `.env` File
When the script stops after opening the `.env` file, update the environment variables as needed. After you're done editing, save the file and exit nano by pressing Ctrl + X, followed by Y and Enter.

### Step 3: Build and start Docker containers
```bash
sudo docker compose up -d --build
```
### Step 4: Run database migrations
```bash
sudo docker compose exec app python manage.py migrate
```
### Step 5: Collect static files
```bash
sudo docker compose run app python manage.py collectstatic --noinput
```
### Step 6: Check app status
```bash
sudo docker compose exec app python manage.py status
```
### Step 7: Create superuser
```bash
sudo docker compose run app python manage.py createsuperuser --username kentemman --email super@user.com
```
