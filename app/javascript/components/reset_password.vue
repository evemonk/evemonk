<template>
  <div id="reset_password_form">
    <vue-headful :title="title" />

    <v-breadcrumbs :items="breadcrumbs">
      <v-icon slot="divider">chevron_right</v-icon>
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
  export default {
    data () {
      return {
        title: 'Reset password | EveMonk: EveOnline management suite',
        valid: true,
        token: null,
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
      this.token = this.$route.params.token;
    },

    methods: {
      submit() {
        const payload = {
          reset_password: {
            token: this.token,
            password: this.password,
            password_confirmation: this.password_confirmation
          }
        };


      },

      clearBaseErrors() {
        this.errors.base = [];
      }
    }
  }
</script>
