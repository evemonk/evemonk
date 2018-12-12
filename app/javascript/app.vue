<template>
  <div id="app">
    <v-app>
      <v-navigation-drawer app></v-navigation-drawer>
      <v-toolbar app dark color="primary">
        <v-toolbar-side-icon></v-toolbar-side-icon>
        <v-toolbar-title class="white--text">EveMonk</v-toolbar-title>
        <v-spacer></v-spacer>
        <v-btn icon>
          <v-icon>search</v-icon>
        </v-btn>
      </v-toolbar>
      <v-content>
        <v-container fluid>
          <router-view></router-view>
        </v-container>
      </v-content>
      <app-footer></app-footer>
    </v-app>
  </div>
</template>

    // <app-header />
    // <app-flash />
    // <router-view></router-view>

<script>
  // import Header from './components/header.vue';
  // import Flash from './components/flash.vue';
  import Footer from './components/footer.vue';
  import { mapGetters } from 'vuex';

  export default {
    name: 'app',
    components: {
      // 'app-header': Header,
      // 'app-flash': Flash,
      'app-footer': Footer,
    },

    computed: {
      ...mapGetters([
        'isAuthenticated'
      ])
    },

    watch: {
      isAuthenticated (value) {
        if (!value) this.$router.push('/');
      }
    }
}
</script>
