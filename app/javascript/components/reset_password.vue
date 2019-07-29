<template>
  <div id="reset_password_form">
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
      <v-text-field id="password"
                    type="password"
                    label="New password"
                    :error-messages="errors.password"
                    v-model="password"
                    required>
      </v-text-field>

      <v-text-field id="password_confirmation"
                    type="password"
                    label="New password confirmation"
                    :error-messages="errors.password_confirmation"
                    v-model="password_confirmation"
                    required>
      </v-text-field>

      <v-btn id="reset_password_button" @click="submit" color="primary">Reset password</v-btn>
    </v-form>
  </div>
</template>

<script>
  import { mapActions, mapMutations } from 'vuex';

  export default {
    data () {
      return {
        title: 'Reset password | EveMonk: EveOnline management suite',
        valid: true,
        reset_password_token: null,
        password: null,
        password_confirmation: null,
        errors: {
          base: [],
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
            text: 'Reset password',
            to: { name: 'reset_password' },
            exact: true,
            disabled: true
          }
        ]
      }
    },

    created () {
      this.reset_password_token = this.$route.params.token;
    },

    methods: {
      ...mapActions([
        'resetPassword'
      ]),

      ...mapMutations([
        'SET_ALERT'
      ]),

      submit() {
        const payload = {
          reset_password: {
            reset_password_token: this.reset_password_token,
            password: this.password,
            password_confirmation: this.password_confirmation
          }
        };

        this.resetPassword(payload).then(response => {
          if (response && response.status === 200) {
            let type = "success";
            let message = "Password was successful reset.";

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
