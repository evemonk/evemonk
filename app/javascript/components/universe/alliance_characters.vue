<template>
  <div id="characters">
    <v-breadcrumbs :items="breadcrumbs">
      <v-icon slot="divider">chevron_right</v-icon>
    </v-breadcrumbs>


    <h1>Alliances</h1>

    <v-pagination v-model="current_page" :length="total_pages"></v-pagination>

    <div>{{ characters.length }}</div>

    <v-pagination v-model="current_page" :length="total_pages"></v-pagination>
  </div>
</template>

<script>
  import { mapActions } from 'vuex';

  export default {
    data () {
      return {
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
          {
            text: 'Alliances',
            to: { name: 'alliances' },
            exact: true
          }
        ]
      }
    },

    watch: {
      current_page: function (page) {
        this.fetchAllianceCharacters({ id: this.alliance_id,
                                       page: page }).then(response => {
          if (response.status === 200) {
            this.total_count = response.data.total_count;
            this.total_pages = response.data.total_pages;
            this.characters = response.data.characters;

            this.$router.push({
              name: 'alliance_characters',
              params: {
                id: this.alliance_id
              },
              query: {
                page: page
              }
            });
          }
        })
      }
    },

    created () {
      this.alliance_id = this.$route.params.id;

      let id = this.$route.params.id;

      this.fetchAlliance(id).then(response => {
        if (response.status === 200) {
          let alliance = response.data.alliance;

          this.alliance = alliance;

          this.breadcrumbs.push({
            text: alliance.name,
            to: {
              name: 'alliance',
              params: {
                id: alliance.id
              }
            },
            exact: true
          });

          this.breadcrumbs.push({ 
            text: 'Characters',
            to: {
              name: 'alliance_characters',
              params: {
                id: alliance.id
              }
            },
            exact: true,
            disabled: true
          });
        }
      });

      let page = this.$route.query.page;

      if (page !== undefined) {
        this.current_page = parseInt(page);
      }

      this.fetchAllianceCharacters({ id: id, page: this.current_page }).then(response => {
        if (response.status === 200) {
          this.total_count = response.data.total_count;
          this.total_pages = response.data.total_pages;
          this.characters = response.data.characters;
        }
      });
    },

    methods: {
      ...mapActions([
        'fetchAlliance',
        'fetchAllianceCharacters'
      ])
    }
  }
</script>
