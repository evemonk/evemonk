<template>
</template>

<script>
  import store from '../store';

  export default {
    data () {
      return {
      }
    },

    created() {
      let token = this.$route.params.token;

      store.commit('SIGN_IN_USER_WITH_TOKEN', token);

      this.$router.push('/profile');
    }
  }
</script>
