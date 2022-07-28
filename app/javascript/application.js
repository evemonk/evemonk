// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

import "controllers";
import "@hotwired/turbo-rails";

import LocalTime from "local-time";
import { install } from "@github/hotkey";
import $ from "jquery";
import "popper.js";
import "bootstrap";

window.$ = window.jQuery = $;

LocalTime.start();

document.addEventListener("turbo:load", () => {
  $('[data-toggle="tooltip"]').tooltip();

  // Install all the hotkeys on the page
  for (const el of document.querySelectorAll("[data-hotkey]")) {
    install(el);
  }
});
