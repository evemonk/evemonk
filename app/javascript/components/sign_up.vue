<template>
  <div id="sign_up">
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
      <v-btn @click="submit" color="primary">Sign Up</v-btn>

    </v-form>

    <v-divider></v-divider>

    <a href="/auth/eve_online_sso">
      <v-img src="https://images.contentful.com/idjq7aai9ylm/4fSjj56uD6CYwYyus4KmES/4f6385c91e6de56274d99496e6adebab/EVE_SSO_Login_Buttons_Large_Black.png?w=270&h=45" width="270" height="45" alt="Sign in via EveOnline SSO"></v-img>
    </a>
  </div>
</template>

<script>
  import { mapActions, mapMutations } from 'vuex';

  export default {
    data () {
      return {
        valid: true,
        email: '',
        password: '',
        password_confirmation: '',
        errors: {
          base: [],
          email: [],
          password: [],
          password_confirmation: []
        }
      }
    },

    methods: {
      ...mapActions({
        'signUp': 'signUp'
      }),

      ...mapMutations({
        'setFlash': 'setFlash'
      }),

      submit () {
        const formData = {
          sign_up: {
            email: this.email,
            password: this.password,
            password_confirmation: this.password_confirmation
          }
        };

        this.signUp(formData).then(response => {
          if (response && response.status === 200) {
            // let type = "success";
            // let message = "Successful signed up!";

            // this.setFlash(type, message);

            this.$router.push('/profile');
          } else if (response.response && response.response.status === 422) {
            this.valid = false;
            this.errors = response.response.data.errors;
          }
        });
      }
    }
  }
</script>
