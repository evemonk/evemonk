<template>
  <div id="characters">
    <h1>Characters</h1>
  </div>
</template>

<script>
  import { mapActions } from 'vuex';

  export default {
    data () {
      return {
        current_page: 1,
        characters: []
      }
    },

    created () {
      this.fetchCharacters(this.current_page).then(response => {
        if (response.status === 200) {
          this.total_count = response.data.total_count;
          this.total_pages = response.data.total_pages;
          this.characters = response.data.characters;
        } else {
          //this.$router.push('/sign_in');
        }
      });
    },

    methods: {
      ...mapActions({
        'fetchCharacters': 'fetchCharacters'
      })
    }
  }
</script>
