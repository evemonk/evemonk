# EveMonk back-end and web front-end

[![CircleCI](https://circleci.com/gh/evemonk/evemonk/tree/master.svg?style=svg)](https://circleci.com/gh/evemonk/evemonk/tree/master)
[![Test Coverage](https://codeclimate.com/github/evemonk/evemonk/badges/coverage.svg)](https://codeclimate.com/github/evemonk/evemonk/coverage)
[![security](https://hakiri.io/github/evemonk/evemonk/master.svg)](https://hakiri.io/github/evemonk/evemonk/master)
[![](https://images.microbadger.com/badges/image/biow0lf/evemonk.svg)](https://microbadger.com/images/biow0lf/evemonk)

EveMonk is helper software for EVE Online.

Styled with Twitter Bootstrap. And Bootswatch Darkly theme.

Mobile first design.

## Features

* Alliances list
* Corporations list
* Characters list
* Alliance show
* Corporation show
* Character show
* Open Graph tags
* SEO friendly
* Authentication
* User characters info

## Environment

* [rbenv](https://github.com/rbenv/rbenv)
* [ruby-build](https://github.com/rbenv/ruby-build)
* [asdf](https://github.com/asdf-vm/asdf)
* [asdf-nodejs](https://github.com/asdf-vm/asdf-nodejs)
* Ruby 2.7.0
* RubyGems 3.1.2
* Bundler 2.1.4
* Ruby on Rails 6-0-stable
* PostgreSQL 12.1
* Redis 5.0.7
* Elasticsearch 7.6.0
* Node 12.16.0
* NPM 6.13.7
* Yarn 1.22.0
* Bootstrap 4.4.1
* Bootstrap Icons 1.0.0-alpha2
* Bootswatch Darkly 4.4.1

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
* [A free guide to HTML5 <head> elements](https://htmlhead.dev)

## Author

* Igor Zubkov (@biow0lf)

## License

EveMonk is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
