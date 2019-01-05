<template>
  <div id="characters">
    <v-breadcrumbs :items="breadcrumbs">
      <v-icon slot="divider">chevron_right</v-icon>
    </v-breadcrumbs>

    <v-pagination v-model="current_page" :length="total_pages"></v-pagination>

    <v-card>
      <v-container fluid grid-list-lg>
        <v-layout row wrap>
          <v-flex xs12 v-for="character in characters" :key="character.id">
            <v-card dark>
              <v-layout>
                <v-flex xs5>
                  <v-img :src="character.icon" height="128px" contain></v-img>
                </v-flex>
                <v-flex xs7>
                  <v-card-title primary-title>
                    <div>
                      <div class="headline">{{ character.name }}</div>
                      <div>{{ character.corporation.name }} / {{ character.alliance.name }}</div>
                      <div>Birthday {{ character.birthday }}</div>
                    </div>
                  </v-card-title>
                </v-flex>
              </v-layout>
              <v-divider light></v-divider>
              <!-- <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="info">
                  <router-link :to="{ name: 'universe_character', params: { id: character.id }}">
                    More
                  </router-link>
                </v-btn>
              </v-card-actions> -->
            </v-card>
          </v-flex>

        </v-layout>
      </v-container>
    </v-card>

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
            to: { name: 'universe_alliances' },
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
              name: 'universe_alliance_characters',
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
              name: 'universe_alliance',
              params: {
                id: alliance.id
              }
            },
            exact: true
          });

          this.breadcrumbs.push({ 
            text: 'Characters',
            to: {
              name: 'universe_alliance_characters',
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
