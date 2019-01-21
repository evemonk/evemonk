<template>
  <div id="corporations">
    Corporations
  </div>
</template>

<script>
  export default {
    data () {
      return {
        corporations: [],
        current_page: 1,
        total_count: null,
        total_pages: null
      }
    }
  }
</script>
