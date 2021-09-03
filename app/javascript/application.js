// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "@hotwired/stimulus-importmap-autoloader"
import { install } from "@github/hotkey"
import "jquery"
import "popper.js"
import "bootstrap"

document.addEventListener("turbo:load", () => {
  // $('[data-toggle="tooltip"]').tooltip();

  // Install all the hotkeys on the page
  for (const el of document.querySelectorAll("[data-hotkey]")) {
    install(el);
  }
});
