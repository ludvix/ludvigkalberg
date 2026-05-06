# Ludvig Kalberg

Personal website and blog built with Ruby on Rails.

## Technology

- Ruby 3.3.6 with Rails 8
- PostgreSQL (Neon)
- Tailwind CSS
- Deployed on Railway

---

## Set up development locally

### WSL / Linux

```bash
# Clone repo
git clone <repo-url>
cd <repo>

# Install rbenv
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'eval "$(~/.rbenv/bin/rbenv init - bash)"' >> ~/.bashrc
source ~/.bashrc

# Install ruby-build
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

# Install dependencies
sudo apt update
sudo apt install -y curl build-essential libssl-dev libreadline-dev zlib1g-dev libffi-dev libyaml-dev git

# Install Ruby
rbenv install 3.3.6
rbenv global 3.3.6
ruby -v

# Install gems
bundle install

# Install PostgreSQL
sudo apt install -y postgresql postgresql-contrib
sudo service postgresql start

# Create PostgreSQL role (replace with your username)
sudo -u postgres psql -c "CREATE ROLE <your-wsl-username> WITH LOGIN CREATEDB;"

# Setup database
bin/rails db:create db:migrate

# Start app
bin/dev
```

---

### macOS

```bash 

# Install Homebrew (if not installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Clone repo
git clone <repo-url>
cd <repo>

# Install rbenv
brew install rbenv ruby-build
rbenv init
echo 'eval "$(rbenv init -)"' >> ~/.zshrc
source ~/.zshrc

# Install Ruby
rbenv install 3.3.6
rbenv global 3.3.6
ruby -v

# Install gems
bundle install

# Install PostgreSQL
brew install postgresql
brew services start postgresql

# Create PostgreSQL role (replace with your username)
psql postgres -c "CREATE ROLE <your-mac-username> WITH LOGIN CREATEDB;"

# Setup database
bin/rails db:create db:migrate

# Start app
bin/dev
```

---

### Windows
```bash
# Install Ruby
# Go to https://rubyinstaller.org
# Download Ruby 3.3.6 with Devkit
# Run installer and press Enter to install MSYS2

# Verify Ruby
ruby -v

# Install bundler
gem install bundler

# Clone repo
git clone <repo-url>
cd <repo>

# Install gems
bundle install

# Install PostgreSQL
# Download from https://postgresql.org
# Start service (replace version if needed)
net start postgresql-x64-17

# Update config/database.yml with:
# username: postgres
# password: your_postgres_password
# host: localhost

# Setup database
bin/rails db:create db:migrate

# Start app
bin/dev
```

---

## Hosting using Render, Neon and UptimeRobot (all free)

### 1. Add build script

Create ```bin/render-build.sh``` file.

Inside put:
```bash
#!/usr/bin/env bash
set -o errexit

bundle install
bundle exec rake assets:precompile
bundle exec rake assets:clean
bundle exec rake db:migrate
```

Make it executable and commit it:

```bash
chmod +x bin/render-build.sh
git add .
git commit -m "add render build script"
git push
```

### 2. Create a web service on Render

* Go to [https://render.com](https://render.com) and sign up.
* Click **New -> Web Service** and connect to your github repo
* Set:
    * **Runtime:** Ruby
    * **Build Command:** ./bin/render-build.sh
    * **Start Command:** bundle exec puma -C config/puma.rb

### 3. Set up neon
* Go to [https://neon.com](https://neon.com)
    * **Sign up**
    * **Click new project**
    * **Give name for example same as repo**
    * **Choose region closest to you**
    * **Click Create**
    * **Done, Neon does all for you**

### 4. Set environment variables

In Render dashboard under **Environment** add:

```
DATABASE_URL = neon-connection-string (click connect on the project and it will show connection string)
RAILS_ENV = production
RAILS_MASTER_KEY = xxxxxxxxxxxxxx (check below if you cant find it)
```

### 5. Cant find rails master key?

The master key is never commited to Git for security wise.

You can check if you have the original key:
```bash
cat config/master.key
```

If key is lost we can regenerate it with:
```bash
rm config/credentials.yml.enc
EDITOR="nano" rails credentials:edit # CTRL X right after, if prompted to save type Y then Enter
cat config/master.key # output of this what you put in RAILS_MASTER_KEY
```

Then commit new credentials file, key will be outside of git always.
```bash
git add config/credentials.yml.enc
git commit -m "regenerate credentials"
git push
```

### 6. Uptime robot
Render for free only gives 15 min before it sleeps, so we can use uptime robot to keep awake
* Go to [uptimerobot.com](https://uptimerobot.com) and make a free account
* Add a new **HTTP(S)** monitor pointing to your domain
* Set interval to around **5-10 minutes**

This will keep the website alive for free 24/7 each month.
---

## Website is at
[ludvigkalberg.com](https://ludvigkalberg.com)
