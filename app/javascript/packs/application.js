// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

// https://docs.sentry.io/platforms/javascript/

// When using npm, import Sentry
import * as Sentry from "@sentry/browser";
import { Integrations } from "@sentry/tracing";

Sentry.init({
  dsn: "https://185a236f4b994411a9f33c3c714cb34e@sentry.io/1424888",

  // To set your release version
  release: "evemonk-frontend@0.4.9", // FIXME: use EVEMONK_VERSION for this
  integrations: [new Integrations.BrowserTracing()],

  // Set tracesSampleRate to 1.0 to capture 100%
  // of transactions for performance monitoring.
  // We recommend adjusting this value in production
  tracesSampleRate: 1.0,

  sendDefaultPii: true,
});

import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import LocalTime from "local-time";
import { install } from "@github/hotkey";
import "channels";

Rails.start();
Turbolinks.start();
LocalTime.start();

import "bootstrap";

import "../stylesheets/application";

// import ApexCharts from "apexcharts";

// window.ApexCharts = ApexCharts;
window.$ = $;

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

document.addEventListener("turbolinks:load", () => {
  $('[data-toggle="tooltip"]').tooltip();

  // Install all the hotkeys on the page
  for (const el of document.querySelectorAll("[data-hotkey]")) {
    install(el);
  }
});

// import "controllers";
