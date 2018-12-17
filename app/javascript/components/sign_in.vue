<template>
  <div id="sign_up_form">
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
                    autofocus
                    required>
      </v-text-field>
      <v-text-field id="password"
                    type="password"
                    label="Password"
                    :error-messages="errors.password"
                    v-model="password"
                    required>
      </v-text-field>
      <v-btn id="sign_in_button" @click="submit" color="primary">Sign In</v-btn>
    </v-form>

    <v-divider></v-divider>

    <a href="/auth/eve_online_sso">
      <v-img src="https://images.contentful.com/idjq7aai9ylm/4fSjj56uD6CYwYyus4KmES/4f6385c91e6de56274d99496e6adebab/EVE_SSO_Login_Buttons_Large_Black.png?w=270&h=45" width="270" height="45" alt="Sign in via EveOnline SSO"></v-img>
    </a>
  </div>
</template>

<script>
  import { mapActions } from 'vuex';

  export default {
    data () {
      return {
        valid: true,
        email: '',
        password: '',
        errors: {
          base: [],
          email: [],
          password: []
        },
      }
    },

    methods: {
      ...mapActions({
        'signIn': 'signIn'
      }),

      submit() {
        const formData = {
          sign_in: {
            email: this.email,
            password: this.password
          }
        };

        this.signIn(formData).then(response => {
          if (response && response.status === 200) {
            // let type = "success";
            // let message = "Successful signed in!";

            // this.setFlash(type, message);

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
