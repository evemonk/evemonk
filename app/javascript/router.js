import Vue from 'vue';
import VueRouter from 'vue-router';

import WelcomePage from './components/welcome.vue';
import AutoSignInPage from './components/auto_sign_in.vue';
import SignUpPage from './components/sign_up.vue';
import SignInPage from './components/sign_in.vue';
import SignOut from './components/sign_out.vue';
import Profile from './components/profile.vue';
import Characters from './components/characters.vue';
import UniverseAlliances from './components/universe/alliances.vue';
import UniverseAlliance from './components/universe/alliance.vue';
import UniverseAllianceCharacters from './components/universe/alliance_characters.vue';

Vue.use(VueRouter);

const routes = [
  {
    path: '/',
    name: 'welcome',
    component: WelcomePage,
  },
  {
    path: '/autosignin/:token',
    component: AutoSignInPage,
  },
  {
    path: '/sign_up',
    component: SignUpPage,
  },
  {
    path: '/sign_in',
    component: SignInPage,
  },
  {
    path: '/sign_out',
    component: SignOut,
  },
  {
    path: '/profile',
    component: Profile,
  },
  {
    path: '/characters',
    name: 'characters',
    component: Characters,
  },
  {
    path: '/universe/alliances',
    name: 'universe_alliances',
    component: UniverseAlliances,
  },
  {
    path: '/universe/alliances/:id',
    name: 'universe_alliance',
    component: UniverseAlliance,
  },
  {
    path: '/universe/alliances/:id/characters',
    name: 'universe_alliance_characters',
    component: UniverseAllianceCharacters,
  },

  // otherwise redirect to home
  {
    path: '*',
    redirect: '/',
  },
];

export default new VueRouter({ mode: 'history', routes });
