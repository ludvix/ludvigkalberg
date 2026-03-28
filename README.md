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
````

---

## Website is at
[ludvigkalberg.com](https://ludvigkalberg.com)
