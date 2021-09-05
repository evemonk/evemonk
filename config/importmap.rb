# frozen_string_literal: true

# Use direct uploads for Active Storage (remember to import "@rails/activestorage" in your application.js)
# pin "@rails/activestorage", to: "activestorage.esm.js"

# Use node modules from a JavaScript CDN by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.js"
pin "@hotwired/stimulus", to: "stimulus.js"
pin "@hotwired/stimulus-importmap-autoloader", to: "stimulus-importmap-autoloader.js"
pin_all_from "app/javascript/controllers", under: "controllers"

pin "@rails/ujs", to: "https://ga.jspm.io/npm:@rails/ujs@6.1.4-1/lib/assets/compiled/rails-ujs.js"

pin "@github/hotkey", to: "https://ga.jspm.io/npm:@github/hotkey@1.4.4/dist/index.js"

pin "bootstrap", to: "https://ga.jspm.io/npm:bootstrap@4.6.0/dist/js/bootstrap.js"
pin "jquery", to: "https://ga.jspm.io/npm:jquery@3.6.0/dist/jquery.js"
pin "popper.js", to: "https://ga.jspm.io/npm:popper.js@1.16.1/dist/umd/popper.js"

pin "@sentry/browser", to: "https://ga.jspm.io/npm:@sentry/browser@6.12.0/esm/index.js"
pin "@sentry/core", to: "https://ga.jspm.io/npm:@sentry/core@6.12.0/esm/index.js"
pin "@sentry/hub", to: "https://ga.jspm.io/npm:@sentry/hub@6.12.0/esm/index.js"
pin "@sentry/minimal", to: "https://ga.jspm.io/npm:@sentry/minimal@6.12.0/esm/index.js"
pin "@sentry/types", to: "https://ga.jspm.io/npm:@sentry/types@6.12.0/esm/index.js"
pin "@sentry/utils", to: "https://ga.jspm.io/npm:@sentry/utils@6.12.0/esm/index.js"
pin "tslib", to: "https://ga.jspm.io/npm:tslib@1.14.1/tslib.es6.js"
