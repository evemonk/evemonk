<template>
  <div id="app">
    <app-header />
    <app-flash />
    <router-view></router-view>
  </div>
</template>

<script>
  import Header from './components/header.vue';
  import Flash from './components/flash.vue';
  import { mapGetters } from 'vuex';

  export default {
    name: 'app',
    components: {
      'app-header': Header,
      'app-flash': Flash
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
