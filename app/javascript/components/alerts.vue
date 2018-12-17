<template>
  <div id="alerts">
    <template v-for="(alert, index) in getAlerts">
      <v-alert v-bind:type="alert.type"
               value=true
               dismissible
               v-bind:key="index">
        {{ alert.message }}
      </v-alert>
    </template>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex';

  export default {
    data () {
      return {
      }
    },

    computed: {
      ...mapGetters([
        'getAlerts'
      ])
    },

    created() {
      console.log(this.getAlerts);
    }
  }
</script>
