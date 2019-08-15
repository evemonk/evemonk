<template>
  <div id="alliance">
    <vue-headful :title="headful.title"
                 :image="headful.image"
                 :url="headful.url" />

    <v-breadcrumbs :items="breadcrumbs">
      <v-icon slot="divider">mdi-chevron-right</v-icon>
    </v-breadcrumbs>

    <v-progress-linear :indeterminate="true" v-if="!loaded"></v-progress-linear>

    <v-card v-if="loaded">
      <v-container fluid grid-list-lg>
        <v-layout row wrap>
          <v-flex xs12>
            <v-card>
              <v-layout>
                <v-flex xs5>
                  <v-img :src="alliance.icon.medium" height="128px" contain></v-img>
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
              <v-divider></v-divider>
              <v-card-actions>
                <v-btn text elevation="1">
                  <router-link :to="{ name: 'universe_alliance_corporations', params: { id: alliance.id }}">
                    Corporations ({{ alliance.corporations_count }})
                  </router-link>
                </v-btn>
                <v-spacer></v-spacer>
                <v-btn text elevation="1">
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
        headful: {
          title: 'EveMonk: EveOnline management suite',
          image: '',
          url: '',
        },
        loaded: false,
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

          this.headful.title = `Alliance "${alliance.name}" (${alliance.ticker}) | EveMonk: EveOnline management suite`;
          this.headful.image = alliance.icon;
          this.headful.url = `https://evemonk/universe/alliances/${alliance.id}`;

          this.loaded = true;
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
