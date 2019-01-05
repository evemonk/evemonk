<template>
  <div id="alliance">
    <h1>Hello</h1>
  </div>
</template>

<script>
  import { mapActions } from 'vuex';

  export default {
    data () {
      return {
        alliance: {}
      }
    },

    created () {
      let id = this.$route.params.id;

      this.fetchAlliance(id).then(response => {
        if (response.status === 200) {
          this.alliance = response.data.alliance;
        }
      });
    },

    methods: {
      ...mapActions({
        'fetchAlliance': 'fetchAlliance'
      })
    }
  }
</script>
