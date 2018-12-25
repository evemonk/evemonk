<template>
  <div id="alerts">
    <template v-for="(alert, index) in getAlerts">
      <v-alert v-bind:type="alert.type"
               value=true
               dismissible
               transition="scale-transition"
               v-bind:key="index" @click="clearAlerts">
        {{ alert.message }}
      </v-alert>
    </template>
  </div>
</template>

<script>
  import { mapGetters, mapMutations } from 'vuex';

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

    methods: {
      ...mapMutations([
        'clearAlerts'
      ])
    }
  }
</script>
