<template>
  <div id="characters">
    <vue-headful :title="headful.title"
                 :url="headful.url" />

    <v-breadcrumbs :items="breadcrumbs">
      <v-icon slot="divider">mdi-chevron-right</v-icon>
    </v-breadcrumbs>

    <template v-if="loading">
      <v-progress-linear :indeterminate="true"></v-progress-linear>
    </template>

    <template v-if="loaded">
      <v-pagination v-model="current_page" :length="total_pages"></v-pagination>

      <v-card>
        <v-container fluid grid-list-lg>
          <v-layout row wrap>
            <character-item v-for="character in characters"
                            v-bind:key="character.id"
                            v-bind="character">
            </character-item>
          </v-layout>
        </v-container>
      </v-card>

      <v-pagination v-model="current_page" :length="total_pages"></v-pagination>
    </template>

    <template v-if="error">
      We're sorry, but something went wrong. Please, try again later.
    </template>
  </div>
</template>

<script>
  import { mapActions } from 'vuex';
  import CharacterItem from './character-item.vue';

  export default {
    data () {
      return {
        headful: {
          title: 'Characters | EveMonk: EveOnline management suite',
          url: 'https://evemonk.com/universe/characters',
        },
        loading: true,
        loaded: false,
        error: false,
        characters: [],
        current_page: 1,
        q: '',
        total_count: null,
        total_pages: null,
        breadcrumbs: [
          {
            text: 'Home',
            to: { name: 'welcome' },
            exact: true
          },
          {
            text: 'Characters',
            to: { name: 'universe_characters' },
            exact: true,
            disabled: true
          }
        ]
      }
    },

    components: {
      'character-item': CharacterItem,
    },

    created () {
      let page = this.$route.query.page;

      if (page !== undefined) {
        this.current_page = parseInt(page);
      }

      this.fetchUniverseCharacters({ page: this.current_page, q: this.q }).then(response => {
        if (response.status === 200) {
          this.total_count = response.data.total_count;
          this.total_pages = response.data.total_pages;
          this.characters = response.data.characters;
          this.loaded = true;
          this.loading = false;
        } else {
          this.loading = false;
          this.loaded = false;
          this.error = true;
        }
      });
    },

    watch: {
      current_page: function (page) {
        if (this.loading === false) {
          this.loaded = false;
          this.loading = true;

          this.fetchUniverseCharacters({ page: page, q: this.q }).then(response => {
            if (response.status === 200) {
              this.total_count = response.data.total_count;
              this.total_pages = response.data.total_pages;
              this.characters = response.data.characters;

              this.loaded = true;
              this.loading = false;

              this.$router.push({ name: 'universe_characters',
                                  query: { page: page } });
            }
          });
        }
      },

      '$route.query.page': function (page) {
        if (this.loading === false &&
            page !== undefined &&
            parseInt(page) !== this.current_page) {
          this.current_page = parseInt(page);
        }
      },
    },

    methods: {
      ...mapActions([
        'fetchUniverseCharacters'
      ])
    }
  }
</script>
