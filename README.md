# README

## Setup steps

* Install ruby
* `gem install bundler`
* `bin/bundle install --deployment --with=production`
* `RAILS_ENV=production bin/rake db:migrate` - this will migrate the database structure
* `RAILS_ENV=production bin/rake assets:precompile` - this will compile static assets to public/assets

## Run

`RAILS_ENV=production bin/puma -C config/puma.rb` — this will start a server on port 3000

For an additional environment variables and configuration possibilities, please check `config/puma.rb` and [Puma docs](https://puma.io/puma/Puma/DSL.html)

Puma server accepts [signals](https://github.com/puma/puma/blob/master/docs/signals.md) as well as interacting with systemd via sd_notify
