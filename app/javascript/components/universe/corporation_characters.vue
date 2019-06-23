<template>
  <div id="characters">
  </div>
</template>

<script>
  import { mapActions } from 'vuex';

  import CharacterItem from './character-item.vue';

  export default {
    data () {
      return {
        title: 'EveMonk: EveOnline management suite',
        loaded: false,
        characters: [],
        current_page: 1,
        total_count: null,
        total_pages: null,
        alliance_id: null,
        breadcrumbs: [
          {
            text: 'Home',
            to: { name: 'welcome' },
            exact: true
          },
        ]
      }
    },

    components: {
      'character-item': CharacterItem,
    },

    methods: {
      ...mapActions([
        'fetchUniverseCorporation',
        'fetchUniverseCorporationCharacters'
      ])
    }
  }
</script>
