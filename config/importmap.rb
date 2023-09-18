# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true

pin "@rails/request.js", to: "https://ga.jspm.io/npm:@rails/request.js@0.0.8/src/index.js"

pin "local-time", to: "https://ga.jspm.io/npm:local-time@2.1.0/app/assets/javascripts/local-time.js"

pin "@github/hotkey", to: "https://ga.jspm.io/npm:@github/hotkey@2.0.1/dist/index.js"

pin "@popperjs/core", to: "https://ga.jspm.io/npm:@popperjs/core@2.11.8/lib/index.js"
pin "bootstrap", to: "https://ga.jspm.io/npm:bootstrap@5.2.3/dist/js/bootstrap.esm.js"

pin "stimulus-password-visibility", to: "https://ga.jspm.io/npm:stimulus-password-visibility@2.1.1/dist/stimulus-password-visibility.mjs"

pin "stimulus-autocomplete", to: "https://ga.jspm.io/npm:stimulus-autocomplete@3.1.0/src/autocomplete.js"

# ninja-keys and deps
pin "ninja-keys", to: "https://ga.jspm.io/npm:ninja-keys@1.2.2/dist/ninja-keys.js"
pin "@lit/reactive-element", to: "https://ga.jspm.io/npm:@lit/reactive-element@1.6.3/reactive-element.js"
pin "@lit/reactive-element/decorators/", to: "https://ga.jspm.io/npm:@lit/reactive-element@1.6.3/decorators/"
pin "@material/mwc-icon", to: "https://ga.jspm.io/npm:@material/mwc-icon@0.25.3/mwc-icon.js"
pin "hotkeys-js", to: "https://ga.jspm.io/npm:hotkeys-js@3.8.7/dist/hotkeys.esm.js"
pin "lit", to: "https://ga.jspm.io/npm:lit@2.2.6/index.js"
pin "lit-element/lit-element.js", to: "https://ga.jspm.io/npm:lit-element@3.3.3/lit-element.js"
pin "lit-html", to: "https://ga.jspm.io/npm:lit-html@2.8.0/lit-html.js"
pin "lit-html/directives/", to: "https://ga.jspm.io/npm:lit-html@2.8.0/directives/"
pin "lit/", to: "https://ga.jspm.io/npm:lit@2.2.6/"
pin "tslib", to: "https://ga.jspm.io/npm:tslib@2.6.2/tslib.es6.mjs"
