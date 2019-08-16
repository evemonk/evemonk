import Vue from 'vue';
import Vuex from 'vuex';
import axios from 'axios';

import baseurl from 'baseurl.js';

axios.defaults.baseURL = baseurl;
axios.defaults.headers.common.Accept = 'application/json';
axios.defaults.timeout = 15000; // 15 seconds

Vue.use(Vuex);

const store = new Vuex.Store({
  state: {
    drawer: null,
    currentUser: null,
    session_id: null,
    token: localStorage.getItem('token') || null,
    alerts: [
      // { type: 'info', message: 'Info' },
      // { type: 'success', message: 'Success' },
      // { type: 'warning', message: 'Warning' },
      // { type: 'error', message: 'Error' },
    ],
  },

  getters: {
    isAuthenticated(state) {
      return state.token;
    },

    getDrawer(state) {
      return state.drawer;
    },

    getAlerts(state) {
      return state.alerts;
    },
  },

  mutations: {
    SIGN_IN_USER(state, payload) {
      const token = payload.data.token;
      state.token = token;
      localStorage.setItem('token', token);
    },

    SIGN_IN_USER_WITH_TOKEN(state, token) {
      state.token = token;
      localStorage.setItem('token', token);
    },

    SIGN_OUT_USER(state) {
      state.token = null;
      localStorage.clear();
      state.alerts = [];
    },

    SET_ALERT(state, alert) {
      state.alerts.push(alert);
    },

    CLEAR_ALERTS(state) {
      state.alerts = [];
    },

    SET_DRAWER(state, option) {
      state.drawer = option;
    },
  },

  actions: {
    async signUp({ commit, state }, payload) {
      try {
        const response = await axios.post('/api/sign_up', payload);

        commit('SIGN_IN_USER', response);

        return response;
      } catch (error) {
        return error;
      }
    },

    async signIn({ commit, state }, payload) {
      try {
        const response = await axios.post('/api/sign_in', payload);

        commit('SIGN_IN_USER', response);

        return response;
      } catch (error) {
        return error;
      }
    },

    async signOut({ commit, state }) {
      try {
        await axios.delete('/api/sign_out');
      } finally {
        commit('SIGN_OUT_USER');
      }
    },

    async changePassword({ commit, state }, payload) {
      try {
        const response = await axios.post('/api/change_password', payload);

        commit('SIGN_IN_USER_WITH_TOKEN', response.data.token);

        return response;
      } catch (error) {
        return error;
      }
    },

    async requestPasswordReset({ commit, state }, payload) {
      try {
        return await axios.post('/api/request_password_reset', payload);
      } catch (error) {
        return error;
      }
    },

    async resetPassword({ commit, state }, payload) {
      try {
        const response = await axios.post('/api/reset_password', payload);

        commit('SIGN_IN_USER_WITH_TOKEN', response.data.token);

        return response;
      } catch (error) {
        return error;
      }
    },

    async fetchProfile({ commit, state }) {
      try {
        return await axios.get('/api/profile');
      } catch (error) {
        return error;
      }
    },

    async fetchCharacters({ commit, state }, page) {
      try {
        return await axios.get(`/api/characters?page=${page}`);
      } catch (error) {
        return error;
      }
    },

    async fetchCharacter({ commit, state }, id) {
      try {
        return await axios.get(`/api/characters/${id}`);
      } catch (error) {
        return error;
      }
    },

    async destroyCharacter({ commit, state }, id) {
      try {
        return await axios.delete(`/api/characters/${id}`);
      } catch (error) {
        return error;
      }
    },

    // async fetchCharacterLoyaltyPoint ({ commit, state }, id) {
    //     try {
    //         return await axios.get(`/api/characters/${id}/loyalty_points`);
    //     } catch (error) {
    //         return error;
    //     }
    // },

    async fetchUniverseAlliances({ commit, state }, page) {
      try {
        return await axios.get(`/api/eve/alliances?page=${page}`);
      } catch (error) {
        return error;
      }
    },

    async fetchUniverseAlliance({ commit, state }, id) {
      try {
        return await axios.get(`/api/eve/alliances/${id}`);
      } catch (error) {
        return error;
      }
    },

    async fetchUniverseAllianceCharacters({ commit, state }, { id, page }) {
      try {
        return await axios.get(`/api/eve/alliances/${id}/characters?page=${page}`);
      } catch (error) {
        return error;
      }
    },

    async fetchUniverseAllianceCorporations({ commit, state }, { id, page }) {
      try {
        return await axios.get(`/api/eve/alliances/${id}/corporations?page=${page}`);
      } catch (error) {
        return error;
      }
    },

    async fetchUniverseCorporations({ commit, state }, page) {
      try {
        return await axios.get(`/api/eve/corporations?page=${page}`);
      } catch (error) {
        return error;
      }
    },

    async fetchUniverseCorporation({ commit, state }, id) {
      try {
        return await axios.get(`/api/eve/corporations/${id}`);
      } catch (error) {
        return error;
      }
    },

    async fetchUniverseCorporationCharacters({ commit, state }, { id, page }) {
      try {
        return await axios.get(`/api/eve/corporations/${id}/characters?page=${page}`);
      } catch (error) {
        return error;
      }
    },

    async fetchUniverseCharacters({ commit, state }, { page, q }) {
      try {
        return await axios.get(`/api/eve/characters?page=${page}&q=${q}`);
      } catch (error) {
        return error;
      }
    },

    async fetchUniverseCharacter({ commit, state }, id) {
      try {
        return await axios.get(`/api/eve/characters/${id}`);
      } catch (error) {
        return error;
      }
    },

    async fetchUniverseCharacterCorporationsHistory({ commit, state }, { id, page }) {
      try {
        return await axios.get(`/api/eve/characters/${id}/corporations_history?page=${page}`);
      } catch (error) {
        return error;
      }
    },

    async fetchUniverseTypes({ commit, state }, { page, q }) {
      try {
        return await  axios.get(`/api/eve/types?page=${page}&q=${q}`);
      } catch (error) {
        return error;
      }
    },

    async fetchUniverseType({ commit, state }, id) {
      try {
        return await axios.get(`/api/eve/types/${id}`);
      } catch (error) {
        return error;
      }
    },
  },

  strict: process.env.NODE_ENV !== 'production',
});

export default store;

axios.interceptors.request.use((config) => {
  if (store.state.token) {
    config.headers.Authorization = `Bearer ${store.state.token}`;
  }

  return config;
});
