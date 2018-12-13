<template>
  <v-navigation-drawer app
                       v-model="drawer"
                       absolute>
  </v-navigation-drawer>
</template>

<script>
  import { mapGetters } from 'vuex';

  import store from '../store';

  export default {
    computed: {
      drawer: {
        get() {
          return this.getDrawer();
        },

        set(value) {
          store.commit('setDrawer', value);
        }
      }
    },

    methods: {
      ...mapGetters([
        'getDrawer'
      ])
    }
  }
</script>
