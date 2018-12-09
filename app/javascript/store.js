import Vue from 'vue';
import Vuex from 'vuex';
import axios from 'axios';

axios.defaults.baseURL = 'http://localhost:3000';
axios.defaults.headers.common['Accept'] = 'application/json';
axios.defaults.timeout = 15000; // 15 seconds

axios.interceptors.request.use(config => {
    if (store.state.token) {
        config.headers['Authorization'] = `Bearer ${store.state.token}`;
    }

    return config;
});

Vue.use(Vuex);

let store = new Vuex.Store({
    state: {
        currentUser: null,
        session_id: null,
        token: localStorage.getItem('token') || null
    },

    getters: {
        isAuthenticated (state) {
            return state.token;
        }
    },

    mutations: {
        signInUser (state, payload) {
            const token = payload.data.token;
            state.token = token;
            localStorage.setItem('token', token);
        },

        signInUserWithToken (state, token) {
            state.token = token;
            localStorage.setItem('token', token);
        },

        signOutUser (state) {
            state.token = null;
            localStorage.removeItem('token');
        }
    },

    actions: {
        async signUp ({ commit, state }, payload) {
            try {
                let response = await axios.post('/api/sign_up', payload);

                commit('signInUser', response);

                return response;
            } catch (error) {
                return error;
            }
        },

        async signIn ({ commit, state }, payload) {
            try {
                let response = await axios.post('/api/sign_in', payload);

                commit('signInUser', response);

                return response;
            } catch (error) {
                return error;
            }
        },

        async signOut ({ commit, state }) {
            try {
                await axios.delete('/api/sign_out');
            } catch (error) {
            } finally {
                commit('signOutUser');
            }
        },

        // async fetchProfile ({ commit, state }) {
        //     try {
        //         return await axios.get('/api/profile');
        //     } catch (error) {
        //         return error;
        //     }
        // },

        // async fetchCharacters ({ commit, state }, page) {
        //     try {
        //         return await axios.get(`/api/characters?page=${page}`);
        //     } catch (error) {
        //         return error;
        //     }
        // },

        // async fetchCharacterLoyaltyPoint ({ commit, state }, id) {
        //     try {
        //         return await axios.get(`/api/characters/${id}/loyalty_points`);
        //     } catch (error) {
        //         return error;
        //     }
        // },

        // async fetchAlliances ({ commit, state }, page) {
        //     try {
        //         return await axios.get(`/api/eve/alliances?page=${page}`);
        //     } catch (error) {
        //         return error;
        //     }
        // }
    }
});

export default store;
