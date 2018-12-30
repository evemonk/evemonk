<template>
  <div id="alliance">
    <h1>Hello</h1>
  </div>
</template>

<script>
  export default {
    data () {
      return {
        id: null,
        name: null
      }
    },

    created () {
      console.log(this.$route.params.id);
    }
  }
</script>
