import Vue from 'vue';
import VueRouter from 'vue-router';

import WelcomePage from './components/welcome.vue';
import AutoSignInPage from './components/auto_sign_in.vue';
import SignUpPage from './components/sign_up.vue';
import SignInPage from './components/sign_in.vue';
import SignOut from './components/sign_out.vue';
import Profile from './components/profile.vue';
import Characters from './components/characters.vue';
import Alliances from './components/db/alliances.vue';

Vue.use(VueRouter);

const routes = [
  { path: '/', component: WelcomePage },
  { path: '/autosignin/:token', component: AutoSignInPage },
  { path: '/sign_up', component: SignUpPage },
  { path: '/sign_in', component: SignInPage },
  { path: '/sign_out', component: SignOut },
  { path: '/profile', component: Profile },
  { path: '/characters', component: Characters },
  { path: '/db/alliances', component: Alliances },

  // otherwise redirect to home
  { path: '*', redirect: '/' },
];

export default new VueRouter({ mode: 'history', routes });
