// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

// https://docs.sentry.io/platforms/javascript/

// When using npm, import Sentry
import * as Sentry from "@sentry/browser";

Sentry.init({
  dsn: "https://185a236f4b994411a9f33c3c714cb34e@sentry.io/1424888",
});

require("@rails/ujs").start();
require("channels");

import { Turbo, cable } from "@hotwired/turbo-rails";

import "bootstrap";

import "../stylesheets/application";

import ApexCharts from "apexcharts";
import * as timeago from "timeago.js";
import debounce from "lodash.debounce";

window.ApexCharts = ApexCharts;
window.$ = $;
window.debounce = debounce;

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

document.addEventListener("turbolinks:load", () => {
  $('[data-toggle="tooltip"]').tooltip();
});

document.addEventListener("turbolinks:load", () => {
  const nodes = document.querySelectorAll(".timeago");

  if (nodes.length > 0) {
    timeago.render(nodes);
  }
});

// import "controllers";
