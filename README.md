# EveMonk back-end and web front-end

[![CircleCI](https://circleci.com/gh/evemonk/evemonk/tree/master.svg?style=svg)](https://circleci.com/gh/evemonk/evemonk/tree/master)
[![Known Vulnerabilities](https://snyk.io/test/github/evemonk/evemonk/badge.svg)](https://snyk.io/test/github/evemonk/evemonk)
[![security](https://hakiri.io/github/evemonk/evemonk/master.svg)](https://hakiri.io/github/evemonk/evemonk/master)
[![](https://images.microbadger.com/badges/image/biow0lf/evemonk.svg)](https://microbadger.com/images/biow0lf/evemonk)
[![DeepSource](https://static.deepsource.io/deepsource-badge-light-mini.svg)](https://deepsource.io/gh/evemonk/evemonk/?ref=repository-badge)

EveMonk is helper software for EVE Online.

Styled with Twitter Bootstrap. And Bootswatch Darkly theme.

Mobile first design.

## Features

- Alliances list
- Corporations list
- Characters list
- Alliance show
- Corporation show
- Character show
- Open Graph tags
- SEO friendly
- Authentication
- User characters info

## Screenshots

All screenshots are real and made in Safari on latest macOS Catalina (10.15.3).

![My Characters page](screenshots/my_characters.png)

![My character sheet page](screenshots/character_sheet.png)

![My character employment history page](screenshots/character_employment_history.png)

![My character agents page](screenshots/character_agents.png)

![My character loyalty points page](screenshots/character_loyalty_points.png)

![My character blueprints page](screenshots/character_blueprints.png)

## Environment

- [rbenv](https://github.com/rbenv/rbenv)
- [ruby-build](https://github.com/rbenv/ruby-build)
- [asdf](https://github.com/asdf-vm/asdf)
- [asdf-nodejs](https://github.com/asdf-vm/asdf-nodejs)
- Ruby 2.7.1
- RubyGems 3.1.2
- Bundler 2.1.4
- Ruby on Rails 6.0.3.1
- PostgreSQL 12.3
- Redis 6.0.5
- Elasticsearch 7.7.1
- Node 12.18.0
- NPM 6.14.5
- Yarn 1.22.4
- Bootstrap 4.5.0
- Bootstrap Icons 1.0.0-alpha4
- Bootswatch Darkly 4.5.0

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

- [The official repository for ESI documentation](https://github.com/esi/esi-docs)
- [EVE Swagger Interface](https://esi.evetech.net/ui/)
- [One place to hold all EVE logic recreated in ESI](https://github.com/esi/eve-glue)
- [Eve Online Static Data Export (SDE) and Image Export Collection (IEC) downloader](https://github.com/evemonk/eveonline-sde-iec-downloader)

## Guides

- [Ruby coding style guide](https://github.com/bbatsov/ruby-style-guide)
- [Ruby on Rails style guide](https://github.com/bbatsov/rails-style-guide)
- [Security Guide for Developers](https://github.com/FallibleInc/security-guide-for-developers)
- [Zen Rails Security Checklist](https://github.com/brunofacca/zen-rails-security-checklist)
- [Rails SQL Injection](http://rails-sqli.org)
- [Timeouts for popular Ruby gems](https://github.com/ankane/the-ultimate-guide-to-ruby-timeouts)
- [Swagger specification](http://swagger.io/specification/)
- [HTTP access control (CORS)](https://developer.mozilla.org/en-US/docs/Web/HTTP/Access_control_CORS)
- [The Twelve-Factor App](https://12factor.net/)
- [HTTP Status Codes](https://httpstatuses.com)
- [Idiosyncratic Ruby](https://github.com/janlelis/idiosyncratic-ruby.com)
- [Fundamental programming with ruby examples](https://github.com/khusnetdinov/ruby.fundamental)
- [Rails Directory Structure Guide](https://github.com/jwipeout/rails-directory-structure-guide)
- [A free guide to HTML5 <head> elements](https://htmlhead.dev)
- [Content Security Policy](https://developers.google.com/web/fundamentals/security/csp)
- [CSP Evaluator](https://csp-evaluator.withgoogle.com/?csp=https://evemonk.com/)
- [Security Headers](https://securityheaders.com/?q=https%3A%2F%2Fevemonk.com%2F&followRedirects=on)
- [Content Security Policy - An Introduction](https://scotthelme.co.uk/content-security-policy-an-introduction/)

## Author

- Igor Zubkov (@biow0lf)

## License

EveMonk is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
