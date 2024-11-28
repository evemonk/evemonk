# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"

pin_all_from "app/javascript/controllers", under: "controllers"

pin "@rails/request.js", to: "@rails--request.js.js", preload: false # @0.0.11

pin "local-time", preload: false # @3.0.2

pin "@github/hotkey", to: "@github--hotkey.js" # @3.1.1

pin "@popperjs/core", to: "popper.js", preload: false # @2.11.8
pin "bootstrap", to: "bootstrap.esm.min.js", preload: false # @5.2.3

pin "@stimulus-components/password-visibility", to: "@stimulus-components--password-visibility.js", preload: false # @3.0.0
