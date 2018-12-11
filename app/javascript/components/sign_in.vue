<template>
  <div id="sign_up">
    <template v-if="this.errors.base && this.errors.base.length">
      <v-alert v-for="(base, index) in this.errors.base"
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
                    :error-messages="this.errors.email"
                    autofocus
                    required>
      </v-text-field>
      <v-text-field id="password"
                    type="password"
                    label="Password"
                    :error-messages="this.errors.password"
                    v-model="password"
                    required>
      </v-text-field>
      <v-btn @click="submit">Sign In</v-btn>
    </v-form>
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
