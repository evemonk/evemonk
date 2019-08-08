import Vue from 'vue';
import VueRouter from 'vue-router';

import Welcome from './components/welcome.vue';
import AutoSignIn from './components/auto_sign_in.vue';
import SignUp from './components/sign_up.vue';
import SignIn from './components/sign_in.vue';
import SignOut from './components/sign_out.vue';
import ForgotPassword from './components/forgot_password.vue';
import ResetPassword from './components/reset_password.vue';
import ChangePassword from './components/change_password.vue';
import Profile from './components/profile.vue';
import Characters from './components/characters.vue';
import Character from './components/character.vue';
import LPStore from './components/lpstore.vue';
import UniverseAlliances from './components/universe/alliances.vue';
import UniverseAlliance from './components/universe/alliance.vue';
import UniverseAllianceCharacters from './components/universe/alliance_characters.vue';
import UniverseAllianceCorporations from './components/universe/alliance_corporations.vue';
import UniverseCorporations from './components/universe/corporations.vue';
import UniverseCorporation from './components/universe/corporation.vue';
import UniverseCorporationCharacters from './components/universe/corporation_characters.vue';
import UniverseCharacter from './components/universe/character.vue';
import UniverseCharacters from './components/universe/characters.vue';
import UniverseTypes from './components/universe/types.vue';
import UniverseType from './components/universe/type.vue';

Vue.use(VueRouter);

const routes = [
  {
    path: '/',
    name: 'welcome',
    component: Welcome,
  },
  {
    path: '/autosignin/:token',
    name: 'auto_sign_in',
    component: AutoSignIn,
  },
  {
    path: '/sign_up',
    name: 'sign_up',
    component: SignUp,
  },
  {
    path: '/sign_in',
    name: 'sign_in',
    component: SignIn,
  },
  {
    path: '/sign_out',
    name: 'sign_out',
    component: SignOut,
  },
  {
    path: '/forgot_password',
    name: 'forgot_password',
    component: ForgotPassword,
  },
  {
    path: '/reset_password/:token',
    name: 'reset_password',
    component: ResetPassword,
  },
  {
    path: '/change_password',
    name: 'change_password',
    component: ChangePassword,
  },
  {
    path: '/profile',
    name: 'profile',
    component: Profile,
  },
  {
    path: '/characters',
    name: 'characters',
    component: Characters,
  },
  {
    path: '/characters/:id',
    name: 'character',
    component: Character,
  },
  {
    path: '/lpstore',
    name: 'lpstore',
    component: LPStore,
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
  {
    path: '/universe/alliances/:id/corporations',
    name: 'universe_alliance_corporations',
    component: UniverseAllianceCorporations,
  },
  {
    path: '/universe/corporations',
    name: 'universe_corporations',
    component: UniverseCorporations,
  },
  {
    path: '/universe/corporations/:id',
    name: 'universe_corporation',
    component: UniverseCorporation,
  },
  {
    path: '/universe/corporations/:id/characters',
    name: 'universe_corporation_characters',
    component: UniverseCorporationCharacters,
  },
  {
    path: '/universe/characters',
    name: 'universe_characters',
    component: UniverseCharacters,
  },
  {
    path: '/universe/characters/:id',
    name: 'universe_character',
    component: UniverseCharacter,
  },
  {
    path: '/universe/types',
    name: 'universe_types',
    component: UniverseTypes,
  },
  {
    path: '/universe/types/:id',
    name: 'universe_type',
    component: UniverseType,
  },
  {
    path: '/.well-known/change-password',
    redirect: '/change_password',
  },

  // otherwise redirect to home
  {
    path: '*',
    redirect: '/',
  },
];

export default new VueRouter({ mode: 'history', routes });
