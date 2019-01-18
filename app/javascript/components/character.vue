<template>
  <div id="character">
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
        }
      }
    },

    created () {
      let id = this.$route.params.id;

      console.log(id);

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
