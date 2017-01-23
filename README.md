# EveMonk back-end and web front-end

[![Build Status](https://travis-ci.org/biow0lf/evemonk.svg?branch=master)](https://travis-ci.org/biow0lf/evemonk)
[![Dependency Status](https://gemnasium.com/badges/github.com/biow0lf/evemonk.svg)](https://gemnasium.com/github.com/biow0lf/evemonk)
[![Code Climate](https://codeclimate.com/github/biow0lf/evemonk/badges/gpa.svg)](https://codeclimate.com/github/biow0lf/evemonk)
[![Test Coverage](https://codeclimate.com/github/biow0lf/evemonk/badges/coverage.svg)](https://codeclimate.com/github/biow0lf/evemonk/coverage)
[![security](https://hakiri.io/github/biow0lf/evemonk/master.svg)](https://hakiri.io/github/biow0lf/evemonk/master)
[![Issue Count](https://codeclimate.com/github/biow0lf/evemonk/badges/issue_count.svg)](https://codeclimate.com/github/biow0lf/evemonk)

EveMonk is helper software for EveOnline MMORPG.

## Features

* API signup
* API session
* Multiple sessions for clients

## Environment

* Ruby 2.4.0
* RubyGems 2.6.8
* Bundler 1.14.2
* Ruby on Rails 5.0.0.1
* PostgreSQL 9.5.4

## Configure

Apple Push notifications:

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

* [EVE Online Third-Party Developer Documentation](https://eveonline-third-party-documentation.readthedocs.io/en/latest/)
* [ESI Swagger](https://esi.tech.ccp.is/latest/)
* [Eve Online Static Data Export (SDE) and Image Export Collection (IEC) downloader](https://github.com/biow0lf/eveonline-sde-iec-downloader)

## Guides

* [Ruby coding style guide](https://github.com/bbatsov/ruby-style-guide)
* [Ruby on Rails style guide](https://github.com/bbatsov/rails-style-guide)
* [Security Guide for Developers](https://github.com/FallibleInc/security-guide-for-developers)
* [Rails SQL Injection](http://rails-sqli.org)
* [Swagger specification](http://swagger.io/specification/)

## Author

* Igor Zubkov (@biow0lf)

## License

EveMonk is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
