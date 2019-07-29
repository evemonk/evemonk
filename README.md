# EveMonk back-end and web front-end

[![Build Status](https://travis-ci.org/evemonk/evemonk.svg?branch=master)](https://travis-ci.org/evemonk/evemonk)
[![Test Coverage](https://codeclimate.com/github/evemonk/evemonk/badges/coverage.svg)](https://codeclimate.com/github/evemonk/evemonk/coverage)
[![security](https://hakiri.io/github/evemonk/evemonk/master.svg)](https://hakiri.io/github/evemonk/evemonk/master) [![Greenkeeper badge](https://badges.greenkeeper.io/evemonk/evemonk.svg)](https://greenkeeper.io/)

EveMonk is helper software for EveOnline MMORPG.

## Features

* API Sign Up
* API Sign In
* API Sign Out
* API Session list
* API End session
* API current user profile
* Multiple API sessions for clients
* API list characters
* API remove character
* Sign Up page
* Sign In page
* Sign Out
* Change password
* Reset password
* Profile page
* Character page with:
  * Name
  * Bio
  * Birthday
  * Gender
  * Race
  * Bloodline
  * Ancestry
  * Faction
  * Alliance
  * Corporation
  * Security status
  * Wallet
  * Perception
  * Memory
  * Willpower
  * Intelligence
  * Charisma
  * Bonus Remaps Available

## Environment

* [rbenv](https://github.com/rbenv/rbenv)
* [ruby-build](https://github.com/rbenv/ruby-build)
* [asdf](https://github.com/asdf-vm/asdf)
* [asdf-nodejs](https://github.com/asdf-vm/asdf-nodejs)
* Ruby 2.6.3
* RubyGems 3.0.4
* Bundler 2.0.2
* Ruby on Rails 6.0.0.rc2
* PostgreSQL 11.4
* Redis 5.0.5
* Elasticsearch 7.2.0
* Node 10.16.0
* NPM 6.10.2
* Yarn 1.17.3
* Vue 2.6.10
* vuex 3.1.1
* vue-router 3.0.7
* Vuetify 1.5.16

## Configure

Apple iOS Push notifications:

```ruby
app = Rpush::Apns::App.new
app.name = 'ios'
app.certificate = File.read('/path/to/production.pem')
app.environment = 'production' # APNs environment.
app.password = 'certificate password'
app.connections = 1
app.save!
```

## Links

* [The official repository for ESI documentation](https://github.com/esi/esi-docs)
* [EVE Swagger Interface](https://esi.evetech.net/ui/?datasource=tranquility)
* [One place to hold all EVE logic recreated in ESI](https://github.com/esi/eve-glue)
* [Eve Online Static Data Export (SDE) and Image Export Collection (IEC) downloader](https://github.com/evemonk/eveonline-sde-iec-downloader)

## Guides

* [Ruby coding style guide](https://github.com/bbatsov/ruby-style-guide)
* [Ruby on Rails style guide](https://github.com/bbatsov/rails-style-guide)
* [Security Guide for Developers](https://github.com/FallibleInc/security-guide-for-developers)
* [Zen Rails Security Checklist](https://github.com/brunofacca/zen-rails-security-checklist)
* [Rails SQL Injection](http://rails-sqli.org)
* [Timeouts for popular Ruby gems](https://github.com/ankane/the-ultimate-guide-to-ruby-timeouts)
* [Swagger specification](http://swagger.io/specification/)
* [HTTP access control (CORS)](https://developer.mozilla.org/en-US/docs/Web/HTTP/Access_control_CORS)
* [The Twelve-Factor App](https://12factor.net/)
* [HTTP Status Codes](https://httpstatuses.com)
* [Idiosyncratic Ruby](https://github.com/janlelis/idiosyncratic-ruby.com)
* [Fundamental programming with ruby examples](https://github.com/khusnetdinov/ruby.fundamental)
* [Rails Directory Structure Guide](https://github.com/jwipeout/rails-directory-structure-guide)

## Documentation

* [Hypertext Transfer Protocol (HTTP/1.1): Message Syntax and Routing](https://tools.ietf.org/html/rfc7230)
* [Hypertext Transfer Protocol (HTTP/1.1): Semantics and Content](https://tools.ietf.org/html/rfc7231)
* [Hypertext Transfer Protocol (HTTP/1.1): Conditional Requests](https://tools.ietf.org/html/rfc7232)
* [Hypertext Transfer Protocol (HTTP/1.1): Range Requests](https://tools.ietf.org/html/rfc7233)
* [Hypertext Transfer Protocol (HTTP/1.1): Caching](https://tools.ietf.org/html/rfc7234)
* [Hypertext Transfer Protocol (HTTP/1.1): Authentication](https://tools.ietf.org/html/rfc7235)
* [Initial Hypertext Transfer Protocol (HTTP) Authentication Scheme Registrations](https://tools.ietf.org/html/rfc7236)
* [Initial Hypertext Transfer Protocol (HTTP) Method Registrations](https://tools.ietf.org/html/rfc7237)
* [HTTP Strict Transport Security (HSTS)](https://tools.ietf.org/html/rfc6797)

## Author

* Igor Zubkov (@biow0lf)

## License

EveMonk is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
