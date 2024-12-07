# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"

pin_all_from "app/javascript/controllers", under: "controllers"

pin "@rails/request.js", to: "https://ga.jspm.io/npm:@rails/request.js@0.0.11/src/index.js", preload: false

pin "local-time", to: "https://ga.jspm.io/npm:local-time@3.0.2/app/assets/javascripts/local-time.es2017-esm.js", preload: false

pin "@github/hotkey", to: "https://ga.jspm.io/npm:@github/hotkey@3.1.1/dist/index.js", preload: false

pin "@popperjs/core", to: "popper.js", preload: false # @2.11.8
pin "bootstrap", to: "bootstrap.esm.min.js", preload: false # @5.2.3

pin "stimulus-password-visibility", to: "https://ga.jspm.io/npm:stimulus-password-visibility@2.1.1/dist/stimulus-password-visibility.mjs", preload: false
