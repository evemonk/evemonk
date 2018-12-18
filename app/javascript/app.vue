<template>
  <div id="app">
    <v-app>
      <app-drawer></app-drawer>
      <app-toolbar></app-toolbar>
      <v-content>
        <v-container fluid>
          <app-alerts></app-alerts>
          <router-view></router-view>
        </v-container>
      </v-content>
      <app-footer></app-footer>
    </v-app>
  </div>
</template>

<script>
  import Drawer from './components/drawer.vue';
  import Toolbar from './components/toolbar.vue';
  import Alerts from './components/alerts.vue';
  import Footer from './components/footer.vue';
  import { mapGetters } from 'vuex';

  export default {
    name: 'app',
    components: {
      'app-drawer': Drawer,
      'app-toolbar': Toolbar,
      'app-alerts': Alerts,
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
