/* eslint no-console: 0 */
// Run this example by adding <%= javascript_pack_tag 'evemonk_vue' %> (and
// <%= stylesheet_pack_tag 'evemonk_vue' %> if you have styles in your component)
// to the head of your layout file,
// like app/views/layouts/application.html.erb.
// All it does is render <div>Hello Vue</div> at the bottom of the page.

import 'bootstrap';

import Vue from 'vue';
import App from '../app.vue';

import router from '../router';
import store from '../store';

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#app',
    router,
    store,
    render: h => h(App),
  });

  console.log(app);
});
