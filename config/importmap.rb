# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/stimulus", to: "stimulus.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers", preload: true
pin "@hotwired/turbo-rails", to: "turbo.js", preload: true

pin "@rails/ujs", to: "https://ga.jspm.io/npm:@rails/ujs@7.0.3/lib/assets/compiled/rails-ujs.js"

pin "@rails/request.js", to: "https://ga.jspm.io/npm:@rails/request.js@0.0.6/src/index.js"

pin "local-time", to: "https://ga.jspm.io/npm:local-time@2.1.0/app/assets/javascripts/local-time.js"

pin "@github/hotkey", to: "https://ga.jspm.io/npm:@github/hotkey@2.0.0/dist/index.js"

pin "bootstrap", to: "https://ga.jspm.io/npm:bootstrap@4.6.1/dist/js/bootstrap.js"
pin "jquery", to: "https://ga.jspm.io/npm:jquery@3.6.0/dist/jquery.js"
pin "popper.js", to: "https://ga.jspm.io/npm:popper.js@1.16.1/dist/umd/popper.js"
