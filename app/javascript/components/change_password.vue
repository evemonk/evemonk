<template>
  <div id="change_password_form">
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
      <v-text-field id="old_password"
                    type="password"
                    label="Current password (leave empty if you are Sign up via Eve Online SSO)"
                    :error-messages="errors.old_password"
                    v-model="old_password"
                    required>
      </v-text-field>

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
      <v-btn id="change_password_button" @click="submit" color="primary">Change password</v-btn>
    </v-form>
  </div>
</template>

<script>
  export default {
    data () {
      return {
        title: 'Change password | EveMonk: EveOnline management suite',
        valid: true,
        old_password: null,
        password: null,
        password_confirmation: null,
        errors: {
          base: [],
          old_password: [],
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
            text: 'Change password',
            to: { name: 'change_password' },
            exact: true,
            disabled: true
          }
        ]
      }
    },

    methods: {
      submit() {
        console.log('good');
      },

      clearBaseErrors() {
        this.errors.base = [];
      }
    }
  }
</script>
