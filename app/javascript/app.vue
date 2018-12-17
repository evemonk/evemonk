<template>
  <div id="app">
    <v-app>
      <app-drawer></app-drawer>
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
  // import Flash from './components/flash.vue';
  import Drawer from './components/drawer.vue';
  import Toolbar from './components/toolbar.vue';
  import Footer from './components/footer.vue';
  import { mapGetters } from 'vuex';

  export default {
    name: 'app',
    components: {
      // 'app-flash': Flash,
      'app-drawer': Drawer,
      'app-toolbar': Toolbar,
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
