<template>
</template>

<script>
  import { mapGetters, mapActions } from 'vuex';

  export default {
    created() {
      this.signOut();
    },

    methods: {
      ...mapActions([
        'signOut'
      ])
    }
  }
</script>
