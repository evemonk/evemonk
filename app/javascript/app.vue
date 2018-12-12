<template>
  <div id="app">
    <v-app>
      <v-navigation-drawer app></v-navigation-drawer>
      <app-toolbar></app-toolbar>
      <v-content>
        <v-container fluid>
          <router-view></router-view>
        </v-container>
      </v-content>
      <app-footer></app-footer>
    </v-app>
  </div>
</template>

<script>
  // import Header from './components/header.vue';
  // import Flash from './components/flash.vue';
  import Footer from './components/footer.vue';
  import Toolbar from './components/toolbar.vue';
  import { mapGetters } from 'vuex';

  export default {
    name: 'app',
    components: {
      // 'app-header': Header,
      // 'app-flash': Flash,
      'app-footer': Footer,
      'app-toolbar': Toolbar,
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
