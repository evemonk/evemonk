<template>
  <div id="alliance">
    <vue-headful :title="title" />

    <v-breadcrumbs :items="breadcrumbs">
      <v-icon slot="divider">chevron_right</v-icon>
    </v-breadcrumbs>

    <v-card>
      <v-container fluid grid-list-lg>
        <v-layout row wrap>
          <v-flex xs12>
            <v-card dark>
              <v-layout>
                <v-flex xs5>
                  <v-img :src="alliance.icon" height="128px" contain></v-img>
                </v-flex>
                <v-flex xs7>
                  <v-card-title primary-title>
                    <div>
                      <div class="headline">{{ alliance.name }}</div>
                      <div>({{ alliance.ticker }})</div>
                      <div>Founded in {{ alliance.date_founded }}</div>
                    </div>
                  </v-card-title>
                </v-flex>
              </v-layout>
              <v-divider light></v-divider>
              <v-card-actions>
                <v-btn color="info">Corporations ({{ alliance.corporations_count }})</v-btn>
                <v-spacer></v-spacer>
                <v-btn color="info">
                  <router-link :to="{ name: 'universe_alliance_characters', params: { id: alliance.id }}">
                    Characters ({{ alliance.characters_count }})
                  </router-link>
                </v-btn>
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
        title: '',
        alliance: {
          id: 0,
          name: '',
          ticker: ''
        },
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

    created () {
      let id = this.$route.params.id;

      this.fetchUniverseAlliance(id).then(response => {
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
            exact: true,
            disabled: true
          });

          this.title = `Alliance "${alliance.name}" (${alliance.ticker}) | EveMonk: EveOnline management suite`;
        }
      });
    },

    methods: {
      ...mapActions([
        'fetchUniverseAlliance'
      ])
    }
  }
</script>
