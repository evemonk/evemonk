<template>
  <div id="profile">
    <vue-headful :title="title" />

    <v-breadcrumbs :items="breadcrumbs">
      <v-icon slot="divider">mdi-chevron-right</v-icon>
    </v-breadcrumbs>

    <h2>Email: {{ email }}</h2>
    <h1>Characters count: {{ characters_count }}</h1>
  </div>
</template>

<script>
  import { mapActions } from 'vuex';

  export default {
    data () {
      return {
        title: 'Profile | EveMonk: EveOnline management suite',
        email: '',
        characters_count: null,
        breadcrumbs: [
          {
            text: 'Home',
            to: { name: 'welcome' },
            exact: true
          },
          {
            text: 'Profile',
            to: { name: 'profile' },
            exact: true
          }
        ]
      }
    },

    created() {
      this.fetchProfile().then(response => {
        if (response.status === 200) {
          this.email = response.data.email;
          this.characters_count = response.data.characters_count;
        } else {
          this.$router.push('/sign_in');
        }
      });
    },

    methods: {
      ...mapActions([
        'fetchProfile'
      ])
    }
  }
</script>
