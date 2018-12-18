<template>
</template>

<script>
  import { mapActions } from 'vuex';

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
