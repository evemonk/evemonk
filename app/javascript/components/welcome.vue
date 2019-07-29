<template>
  <div id="welcome">
    <vue-headful :title="title" />

    <v-breadcrumbs :items="breadcrumbs">
      <v-icon slot="divider">mdi-chevron-right</v-icon>
    </v-breadcrumbs>

    <h1>Welcome!</h1>
  </div>
</template>

<script>
  export default {
    data () {
      return {
        title: 'Welcome! | EveMonk: EveOnline management suite',
        breadcrumbs: [
          {
            text: 'Home',
            to: { name: 'welcome' },
            exact: true
          }
        ]
      }
    }
  }
</script>
