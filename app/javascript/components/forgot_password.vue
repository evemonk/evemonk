<template>
  <div id="forgot_password_form">
    <v-breadcrumbs :items="breadcrumbs">
      <v-icon slot="divider">chevron_right</v-icon>
    </v-breadcrumbs>

    <v-form v-if="!sent">
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
        'forgotPassword'
      ]),

      ...mapMutations([
        'setAlert'
      ]),

      submit() {
        const payload = {
          forgot_password: {
            email: this.email
          }
        };

        this.forgotPassword(payload).then(response => {
          if (response && response.status === 200) {
            let type = "success";
            let message = "Email sent with password reset instructions.";

            this.setAlert({ type, message });

            this.sent = true;
          // } else if (response.response && response.response.status === 422) {
          //   this.valid = false;
          //   this.errors = response.response.data.errors;
          }
        });
      }
    }
  }
</script>
