// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

import "controllers";
import "@hotwired/turbo-rails";

import LocalTime from "local-time";
import { install, uninstall } from "@github/hotkey";
import "@popperjs/core";
import "bootstrap";

LocalTime.start();

document.addEventListener("turbo:load", () => {
  // $('[data-toggle="tooltip"]').tooltip();

  // Install all the hotkeys on the page
  for (const el of document.querySelectorAll("[data-hotkey]")) {
    install(el);
  }
});

document.addEventListener("turbo:before-render", () => {
  // Uninstall all the hotkeys on the page
  for (const el of document.querySelectorAll("[data-hotkey]")) {
    uninstall(el);
  }
});
