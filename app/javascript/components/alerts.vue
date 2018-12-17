<template>
  <div id="alerts">
    <template v-for="(alert, index) in alerts">
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
  export default {
    data () {
      return {
        alerts: [
          { type: 'info', message: 'Info' },
          { type: 'success', message: 'Success' },
          { type: 'warning', message: 'Warning' },
          { type: 'error', message: 'Error' }
        ]
      }
    },

    created() {
      console.log(this.alerts);
    }
  }
</script>
