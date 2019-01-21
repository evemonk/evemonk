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
            <v-card dark>
              <v-layout>
                <v-flex xs5>
                  <v-img :src="character.icon" height="128px" contain></v-img>
                </v-flex>
                <v-flex xs7>
                  <v-card-title primary-title>
                    <div>
                      <div class="headline">{{ character.name }}</div>
                      <div>
                        <router-link :to="{ name: 'universe_corporation', params: { id: character.corporation.id }}">{{ character.corporation.name }}</router-link> /
                        <router-link :to="{ name: 'universe_alliance', params: { id: character.alliance.id }}">{{ character.alliance.name }}</router-link>
                      </div>
                      <div>{{ character.description }}</div>
                    </div>
                  </v-card-title>
                </v-flex>
              </v-layout>
              <v-divider light></v-divider>
              <!--<v-card-actions>-->

              <!--</v-card-actions>-->
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

  </div>
</template>

<script>
  import { mapActions } from 'vuex';

  export default {
    data () {
      return {
        loaded: false,
        character: {
          id: '',
          icon: '',
          name: '',
          description: '',
          birthday: '',
          gender: '',
          alliance: {
            id: '',
            name: ''
          },
          corporation: {
            id: '',
            name: ''
          }
        },
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
