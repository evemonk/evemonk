<template>
  <div id="corporation_characters">
    <vue-headful :title="title" />

    <v-breadcrumbs :items="breadcrumbs">
      <v-icon slot="divider">mdi-chevron-right</v-icon>
    </v-breadcrumbs>

    <v-progress-linear :indeterminate="true" v-if="!loaded"></v-progress-linear>

    <v-pagination v-model="current_page" :length="total_pages" v-if="loaded"></v-pagination>

    <v-card v-if="loaded">
      <v-container fluid grid-list-lg>
        <v-layout row wrap>
          <character-item v-for="character in characters"
                          v-bind:key="character.id"
                          v-bind="character">
          </character-item>
        </v-layout>
      </v-container>
    </v-card>

    <v-pagination v-model="current_page" :length="total_pages" v-if="loaded"></v-pagination>
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
        corporation_id: null,
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

    watch: {
      current_page: function (page) {
        this.fetchUniverseCorporationCharacters({ id: this.corporation_id, page: page }).then(response => {
          if (response.status === 200) {
            this.total_count = response.data.total_count;
            this.total_pages = response.data.total_pages;
            this.characters = response.data.characters;

            this.$router.push({
              name: 'universe_corporation_characters',
              params: {
                id: this.corporation_id
              },
              query: {
                page: page
              }
            });
          }
        });
      },

      // '$route.query.page': function (page) {
      //   if (page !== undefined && parseInt(page) !== this.current_page) {
      //     this.current_page = parseInt(page);
      //   }
      // }
    },

    created () {
      this.corporation_id = this.$route.params.id;

      let id = this.$route.params.id;

      this.fetchUniverseCorporation(id).then(response => {
        if (response.status === 200) {
          let corporation = response.data;

          this.corporation = corporation;

          this.breadcrumbs.push({
            text: corporation.name,
            to: {
              name: 'universe_corporation',
              params: {
                id: corporation.id
              }
            },
            exact: true
          });

          this.breadcrumbs.push({
            text: 'Characters',
            to: {
              name: 'universe_corporation_characters',
              params: {
                id: corporation.id
              }
            },
            exact: true,
            disabled: true
          });

          this.title = `Characters in corporation "${corporation.name}" (${corporation.ticker}) | EveMonk: EveOnline management suite`;
        }
      });

      let page = this.$route.query.page;

      if (page !== undefined) {
        this.current_page = parseInt(page);
      }

      this.fetchUniverseCorporationCharacters({ id: id, page: this.current_page }).then(response => {
        if (response.status === 200) {
          this.total_count = response.data.total_count;
          this.total_pages = response.data.total_pages;
          this.characters = response.data.characters;
          this.loaded = true;
        }
      });
    },

    methods: {
      ...mapActions([
        'fetchUniverseCorporation',
        'fetchUniverseCorporationCharacters'
      ])
    }
  }
</script>
