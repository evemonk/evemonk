<template>
  <div id="character">
    <v-breadcrumbs :items="breadcrumbs">
      <v-icon slot="divider">chevron_right</v-icon>
    </v-breadcrumbs>

    Hello
  </div>
</template>

<script>
  import { mapActions } from 'vuex';

  export default {
    data () {
      return {
        character: {
          id: null,
          icon: null,
          name: null
        },
        breadcrumbs: [
          {
            text: 'Home',
            to: { name: 'welcome' },
            exact: true
          },
          {
            text: 'Characters',
            to: { name: 'characters' },
            exact: true
          }
        ]
      }
    },

    created () {
      let id = this.$route.params.id;

      this.fetchCharacter(id).then(response => {
        if (response.status === 200) {
          this.character = response.data.character;
        } else {
          //this.$router.push('/sign_in');
        }
      });
    },

    methods: {
      ...mapActions([
        'fetchCharacter'
      ])
    }
  }
</script>
