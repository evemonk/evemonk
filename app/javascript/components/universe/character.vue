<template>
  <div id="character">
    <vue-headful :title="headful.title"
                 :description="headful.description"
                 :image="headful.image"
                 :url="headful.url" />

    <v-breadcrumbs :items="breadcrumbs">
      <v-icon slot="divider">mdi-chevron-right</v-icon>
    </v-breadcrumbs>

    <template v-if="loading">
      <v-progress-linear :indeterminate="true"></v-progress-linear>
    </template>

    <template v-if="loaded">
      <v-card itemscope itemtype="http://schema.org/Person">
        <v-container fluid grid-list-lg>
          <v-layout row wrap>
            <v-flex xs12>
              <v-card>
                <v-layout>
                  <v-flex xs5>
                    <v-img :src="character.icon.large" height="128px" contain></v-img>
                  </v-flex>
                  <v-flex xs7>
                    <v-card-title primary-title>
                      <div>
                        <div class="headline" itemprop="name">{{ character.name }}</div>
                        <div>

                          <template v-if="character.corporation && character.alliance">
                            <div>
                              <router-link :to="{ name: 'universe_corporation',
                                                  params: { id: character.corporation.id }}">
                                {{ character.corporation.name }}
                              </router-link> /
                              <router-link :to="{ name: 'universe_alliance',
                                                  params: { id: character.alliance.id }}">
                                {{ character.alliance.name }}
                              </router-link>
                            </div>
                          </template>

                          <template v-else-if="character.corporation">
                            <div>
                              <router-link :to="{ name: 'universe_corporation',
                                                  params: { id: character.corporation.id }}">
                                {{ character.corporation.name }}
                              </router-link>
                            </div>
                          </template>

                          <template v-else-if="character.alliance">
                            <div>
                              <router-link :to="{ name: 'universe_alliance',
                                                  params: { id: character.alliance.id }}">
                                {{ character.alliance.name }}
                              </router-link>
                            </div>
                          </template>

                        </div>

                        <div>{{ character.description }}</div>

                        <div>Birthday: {{ character.birthday }}</div>
                        <div>Gender: {{ character.gender }}</div>
                        <div>Security status: {{ character.security_status }}</div>

                        <v-divider></v-divider>

                        <template v-if="character.race">
                          <div>
                            Race: {{ character.race.name }}
                          </div>
                        </template>
                        <template v-if="character.bloodline">
                          <div>
                            Bloodline: {{ character.bloodline.name }}
                          </div>
                        </template>
                        <template v-if="character.ancestry">
                          <div>
                            Ancestry: {{ character.ancestry.name }}
                          </div>
                        </template>
                        <template v-if="character.faction">
                          <div>
                            Faction: {{ character.faction.name }}
                          </div>
                        </template>
                      </div>
                    </v-card-title>
                  </v-flex>
                </v-layout>
              </v-card>
            </v-flex>

          </v-layout>
        </v-container>
      </v-card>

      <character-corporation-history
        v-bind:key="character.id"
        v-bind="character">
      </character-corporation-history>
    </template>
  </div>
</template>

<script>
  import { mapActions } from 'vuex';
  import CharacterCorporationHistory from './character_corporation_history.vue'

  export default {
    data () {
      return {
        headful: {
          title: 'EveMonk: EveOnline management suite',
          description: '',
          image: '',
          url: '',
        },
        loading: true,
        loaded: false,
        error: false,
        character: {},
        breadcrumbs: [
          {
            text: 'Home',
            to: { name: 'welcome' },
            exact: true
          },
          {
            text: 'Characters',
            to: { name: 'universe_characters' },
            exact: true
          }
        ],
        headers: [
          { text: 'Corporation', value: 'name', sortable: false },
          { text: 'Joined at', value: 'start_date', sortable: false }
        ],
        search: '',
      }
    },

    components: {
      'character-corporation-history': CharacterCorporationHistory,
    },

    created () {
      let id = this.$route.params.id;

      this.fetchUniverseCharacter(id).then(response => {
        if (response.status === 200) {
          let character = response.data.character;

          this.character = character;
          this.loaded = true;
          this.loading = false;

          this.breadcrumbs.push({
            text: character.name,
            to: {
              name: 'universe_character',
              params: {
                id: character.id
              }
            },
            exact: true,
            disabled: true
          });

          this.headful.title = `«${character.name}» | EveMonk: EveOnline management suite`;
          this.headful.description = character.description;
          this.headful.image = character.icon;
          this.headful.url = `https://evemonk/universe/characters/${character.id}`;
        } else {
          this.loading = false;
          this.loaded = false;
          this.error = true;
        }
      });
    },

    methods: {
      ...mapActions([
        'fetchUniverseCharacter'
      ])
    }
  }
</script>
