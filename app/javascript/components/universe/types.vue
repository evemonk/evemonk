<template>
  <div id="types"></div>
</template>

<script>
  import { mapActions } from 'vuex';

  export default {
    methods: {
      ...mapActions([
        'fetchUniverseTypes'
      ])
    }
  }
</script>
