<template>
  <div id="characters">
    <vue-headful :title="title" />

    <v-breadcrumbs :items="breadcrumbs">
      <v-icon slot="divider">chevron_right</v-icon>
    </v-breadcrumbs>

    <v-progress-linear :indeterminate="true" v-if="!loaded"></v-progress-linear>

    <v-pagination v-model="current_page" :length="total_pages" v-if="loaded"></v-pagination>

    <v-card v-if="loaded">
      <v-container fluid grid-list-lg>
        <v-layout row wrap>
          <v-flex xs12 v-for="character in characters" :key="character.id">
            <v-card>
              <v-layout>
                <v-flex xs5>
                  <v-img :src="character.icon" height="128px" contain></v-img>
                </v-flex>
                <v-flex xs7>
                  <v-card-title primary-title>
                    <div>
                      <div class="headline">
                        <router-link :to="{ name: 'character', params: { id: character.id }}">
                          {{ character.name }}
                        </router-link>
                      </div>

                      <template v-if="character.corporation && character.alliance">
                        <div>
                          <router-link :to="{ name: 'universe_corporation', params: { id: character.corporation.id }}">{{ character.corporation.name }}</router-link> /
                          <router-link :to="{ name: 'universe_alliance', params: { id: character.alliance.id }}">{{ character.alliance.name }}</router-link>
                        </div>
                      </template>

                      <template v-else-if="character.corporation">
                        <div>
                          <router-link :to="{ name: 'universe_corporation', params: { id: character.corporation.id }}">{{ character.corporation.name }}</router-link>
                        </div>
                      </template>

                      <template v-else-if="character.alliance">
                        <div>
                          <router-link :to="{ name: 'universe_alliance', params: { id: character.alliance.id }}">{{ character.alliance.name }}</router-link>
                        </div>
                      </template>

                    </div>
                  </v-card-title>
                </v-flex>
              </v-layout>
              <v-divider></v-divider>
              <v-card-actions>
                <v-btn color="error" @click="removeCharacter(character.id)">
                  Remove
                </v-btn>
                <v-spacer></v-spacer>
                <v-btn text elevation="1">LPStore</v-btn>
                <v-spacer></v-spacer>
                <v-btn text elevation="1">
                  <router-link :to="{ name: 'character', params: { id: character.id }}">
                    Info
                  </router-link>
                </v-btn>
              </v-card-actions>
            </v-card>
          </v-flex>

        </v-layout>
      </v-container>
    </v-card>

    <v-pagination v-model="current_page" :length="total_pages" v-if="loaded"></v-pagination>
  </div>
</template>

<script>
  import { mapActions } from 'vuex';

  export default {
    data () {
      return {
        title: 'Characters | EveMonk: EveOnline management suite',
        loaded: false,
        current_page: 1,
        total_count: null,
        total_pages: null,
        characters: [],
        breadcrumbs: [
          {
            text: 'Home',
            to: { name: 'welcome' },
            exact: true
          },
          {
            text: 'Characters',
            to: { name: 'characters' },
            exact: true,
            disabled: true
          }
        ]
      }
    },

    watch: {
      current_page: function (page) {
        this.fetchCharacters(page).then(response => {
          if (response.status === 200) {
            this.total_count = response.data.total_count;
            this.total_pages = response.data.total_pages;
            this.characters = response.data.characters;

            this.$router.push({ name: 'characters', query: { page: page } });
          }
        })
      }
    },

    created () {
      this.fetchCharacters(this.current_page).then(response => {
        if (response.status === 200) {
          this.total_count = response.data.total_count;
          this.total_pages = response.data.total_pages;
          this.characters = response.data.characters;
          this.loaded = true;
        } else {
          //this.$router.push('/sign_in');
        }
      });
    },

    methods: {
      ...mapActions([
        'fetchCharacters',
        'destroyCharacter',
      ]),

      removeCharacter (id) {
        this.destroyCharacter(id).then(response => {
          if (response.status === 204) {
            this.fetchCharacters(this.current_page).then(response => {
              if (response.status === 200) {
                this.total_count = response.data.total_count;
                this.total_pages = response.data.total_pages;
                this.characters = response.data.characters;
                this.loaded = true;
              }
            });
          }
        });
      }
    }
  }
</script>
