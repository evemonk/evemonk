<template>
  <div id="sign_up_form">
    <vue-headful :title="title" />

    <v-breadcrumbs :items="breadcrumbs">
      <v-icon slot="divider">mdi-chevron-right</v-icon>
    </v-breadcrumbs>

    <template v-if="errors.base && errors.base.length">
      <v-alert v-for="(base, index) in errors.base"
               color="error"
               type="error"
               dismissible
               :key="index"
               :value="true"
               @click="clearBaseErrors">
        {{ base }}
      </v-alert>
    </template>

    <v-form v-model="valid">
      <v-text-field id="email"
                    type="email"
                    placeholder="john.appleseed@example.com"
                    label="Email:"
                    v-model="email"
                    :error-messages="errors.email"
                    autofocus>
      </v-text-field>
      <v-text-field id="password"
                    type="password"
                    label="Password"
                    :error-messages="errors.password"
                    v-model="password">
      </v-text-field>
      <v-text-field id="password_confirmation"
                    type="password"
                    label="Password confirmation"
                    :error-messages="errors.password_confirmation"
                    v-model="password_confirmation">
      </v-text-field>
      <v-btn id="sign_up_button" @click="submit" color="primary">Sign Up</v-btn>
    </v-form>

    <v-divider></v-divider>

    <a href="/auth/eve_online_sso">
      <v-img src="https://images.contentful.com/idjq7aai9ylm/4fSjj56uD6CYwYyus4KmES/4f6385c91e6de56274d99496e6adebab/EVE_SSO_Login_Buttons_Large_Black.png?w=270&h=45" width="270" height="45" alt="Sign in via EveOnline SSO"></v-img>
    </a>

    <v-divider></v-divider>

    <router-link :to="{ name: 'sign_in' }">Already have an account? Sign In</router-link>
  </div>
</template>

<script>
  import { mapActions, mapMutations } from 'vuex';

  export default {
    data () {
      return {
        title: 'Sign Up | EveMonk: EveOnline management suite',
        valid: true,
        email: null,
        password: null,
        password_confirmation: null,
        errors: {
          base: [],
          email: [],
          password: [],
          password_confirmation: []
        },
        breadcrumbs: [
          {
            text: 'Home',
            to: { name: 'welcome' },
            exact: true
          },
          {
            text: 'Sign Up',
            to: { name: 'sign_up' },
            exact: true,
            disabled: true
          }
        ]
      }
    },

    methods: {
      ...mapActions([
        'signUp'
      ]),

      ...mapMutations([
        'SET_ALERT'
      ]),

      submit () {
        const payload = {
          sign_up: {
            email: this.email,
            password: this.password,
            password_confirmation: this.password_confirmation
          }
        };

        this.signUp(payload).then(response => {
          if (response && response.status === 200) {
            let type = "success";
            let message = "Successful signed up!";

            this.SET_ALERT({ type, message });

            this.$router.push('/profile');
          } else if (response.response && response.response.status === 422) {
            this.valid = false;
            this.errors = response.response.data.errors;
          }
        });
      },

      clearBaseErrors() {
        this.errors.base = [];
      }
    }
  }
</script>
