<template>
  <div id="character">
    <v-breadcrumbs :items="breadcrumbs">
      <v-icon slot="divider">chevron_right</v-icon>
    </v-breadcrumbs>

    <v-progress-linear :indeterminate="true" v-if="!loaded"></v-progress-linear>

    <v-card v-if="loaded">
      <v-container fluid grid-list-lg>
        <v-layout row wrap>
          <v-flex xs12>
            <v-card>
              <v-layout>
                <v-flex xs5>
                  <v-img :src="character.icon" height="128px" contain></v-img>
                </v-flex>
                <v-flex xs7>
                  <v-card-title primary-title>
                    <div>
                      <div class="headline">{{ character.name }}</div>
                      <div>
                        <template v-if="character.corporation">
                          <router-link :to="{ name: 'universe_corporation', params: { id: character.corporation.id }}">{{ character.corporation.name }}</router-link> /
                        </template>
                        <template v-if="character.alliance">
                          <router-link :to="{ name: 'universe_alliance', params: { id: character.alliance.id }}" v-if="character.alliance">{{ character.alliance.name }}</router-link>
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

                      <v-divider></v-divider>

                      <div>Perception: {{ character.perception }}</div>
                      <div>Memory: {{ character.memory }}</div>
                      <div>Willpower: {{ character.willpower }}</div>
                      <div>Intelligence: {{ character.intelligence }}</div>
                      <div>Charisma: {{ character.charisma }}</div>

                      <v-divider></v-divider>

                      <div>Wallet: {{ character.wallet }}</div>

                      <v-divider></v-divider>

                      <div>Bonus Remaps: {{ character.bonus_remaps }}</div>
                      <div>Last Remap Date: {{ character.last_remap_date }}</div>
                      <div>Accured Remap Cooldown Date: {{ character.accrued_remap_cooldown_date }}</div>
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
              </v-card-actions>
            </v-card>
          </v-flex>

        </v-layout>
      </v-container>
    </v-card>

  </div>
</template>

<script>
  import { mapActions } from 'vuex';

  export default {
    data () {
      return {
        loaded: false,
        character: {},
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
          this.loaded = true;
          this.breadcrumbs.push({ text: this.character.name,
                                  exact: true,
                                  disabled: true });
        } else {
          //this.$router.push('/sign_in');
        }
      });
    },

    methods: {
      ...mapActions([
        'fetchCharacter',
        'destroyCharacter',
      ]),

      removeCharacter (id) {
        this.destroyCharacter(id).then(response => {
          if (response.status === 204) {
            this.$router.push('/characters');
          }
        });
      }
    }
  }
</script>
