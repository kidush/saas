source 'https://rubygems.org'

ruby "2.2.3"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.15'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Server gem, un server tra tanti che pero a mio parere gestisce meglio questo tipo di struttura
gem 'puma'

# Autenticazione e asincrono per mail e background work e per per invitare nuovi utenti
gem 'devise'
gem 'devise-async'
gem 'devise_invitable'

# Rolify e CanCanCan, gestore di permessi per la nostra SaaS application
gem 'cancancan'
gem 'rolify'

# Migliore indentazione per ruby console
gem 'awesome_print'

# Background work per asincrono
gem 'sidekiq'

# Stripe per i pagamenti & Stripe event per processare gli eventi stripe
gem 'stripe'
gem 'stripe_event'

# Multi-tenant gem & supporto per async con Sidekiq
gem 'apartment'
gem 'apartment-sidekiq'

# serve per aprire le mail direttamente nel browser per debug
gem 'letter_opener'

# NON RICORDO COSA FA QUESTA GEMMA AHAHAHHA ****** devo controllare ******
gem 'rails_12factor'

# Gem per utilizzare will_paginate con materialize
gem 'will_paginate', '~> 3.0.6'
gem 'will_paginate-materialize'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  # gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

