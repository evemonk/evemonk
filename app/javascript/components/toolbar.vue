<template>
  <v-app-bar max-height="64">
    <v-app-bar-nav-icon @click="showDrawer"></v-app-bar-nav-icon>
    <v-toolbar-title class="white--text">EveMonk</v-toolbar-title>
    <v-spacer></v-spacer>
    <v-btn icon>
      <v-icon>mdi-magnify</v-icon>
    </v-btn>
  </v-app-bar>
</template>

<script>
  import { mapGetters } from 'vuex';

  import store from '../store';

  export default {
    methods: {
      ...mapGetters([
        'getDrawer'
      ]),

      showDrawer() {
        store.commit('SET_DRAWER', !this.getDrawer());
      },
    }
  }
</script>
