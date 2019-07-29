<template>
  <div id="forgot_password_form">
    <vue-headful :title="title" />

    <v-breadcrumbs :items="breadcrumbs">
      <v-icon slot="divider">mdi-chevron-right</v-icon>
    </v-breadcrumbs>

    <v-form v-model="valid" v-if="!sent">
      <v-text-field id="email"
                    type="email"
                    placeholder="john.appleseed@example.com"
                    label="Email:"
                    v-model="email"
                    :error-messages="errors.email"
                    autofocus
                    required>
      </v-text-field>

      <v-btn id="forgot_password_button" @click="submit" color="primary">Send Reset Email</v-btn>
    </v-form>
  </div>
</template>

<script>
  import { mapActions, mapMutations } from 'vuex';

  export default {
    data () {
      return {
        title: 'Forgot password | EveMonk: EveOnline management suite',
        valid: true,
        sent: false,
        email: '',
        errors: {
          email: []
        },
        breadcrumbs: [
          {
            text: 'Home',
            to: { name: 'welcome' },
            exact: true
          },
          {
            text: 'Forgot password',
            to: { name: 'forgot_password' },
            exact: true,
            disabled: true
          }
        ]
      }
    },

    methods: {
      ...mapActions([
        'requestPasswordReset'
      ]),

      ...mapMutations([
        'SET_ALERT'
      ]),

      submit() {
        const payload = {
          request_password_reset: {
            email: this.email
          }
        };

        this.requestPasswordReset(payload).then(response => {
          if (response && response.status === 200) {
            let type = "success";
            let message = "Email sent with password reset instructions.";

            this.SET_ALERT({ type, message });

            this.sent = true;
          } else if (response.response && response.response.status === 422) {
            this.valid = false;
            this.errors = response.response.data.errors;
          }
        });
      }
    }
  }
</script>
