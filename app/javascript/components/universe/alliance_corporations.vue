<template>
  <div id="alliance_corporations">
    <vue-headful :title="title" />

    <v-breadcrumbs :items="breadcrumbs">
      <v-icon slot="divider">chevron_right</v-icon>
    </v-breadcrumbs>

    <v-progress-linear :indeterminate="true" v-if="!loaded"></v-progress-linear>

    <v-pagination v-model="current_page" :length="total_pages" v-if="loaded"></v-pagination>

      <v-card v-if="loaded">
        <v-container fluid grid-list-lg>
          <v-layout row wrap>
            <v-flex xs12 v-for="corporation in corporations" :key="corporation.id">
              <v-card dark>
                <v-layout>
                  <v-flex xs5>
                    <v-img :src="corporation.icon" height="128px" contain></v-img>
                  </v-flex>
                  <v-flex xs7>
                    <v-card-title primary-title>
                      <div>
                        <div class="headline">
                          {{ corporation.name }}
                        </div>
                        <div>({{ corporation.ticker }})</div>
                        <div>Founded in {{ corporation.date_founded }}</div>
                      </div>
                    </v-card-title>
                  </v-flex>
                </v-layout>
                <v-divider light></v-divider>
                  <v-card-actions>
                    <v-btn color="info">
                      Characters ({{ corporation.member_count }})
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
        title: 'EveMonk: EveOnline management suite',
        loaded: false,
        current_page: 1,
        corporations: [],
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

    created () {
      this.alliance_id = this.$route.params.id;

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
            exact: true
          });

          this.breadcrumbs.push({
            text: 'Corporations',
            to: {
              name: 'universe_alliance_corporations',
              params: {
                id: alliance.id
              }
            },
            exact: true,
            disabled: true
          });

          this.title = `Corporations in alliance "${alliance.name}" (${alliance.ticker}) | EveMonk: EveOnline management suite`;
        }
      });

      let page = this.$route.query.page;

      if (page !== undefined) {
        this.current_page = parseInt(page);
      }

      this.fetchUniverseAllianceCorporations({ id: id, page: this.current_page }).then(response => {
        if (response.status === 200) {
          this.total_count = response.data.total_count;
          this.total_pages = response.data.total_pages;
          this.corporations = response.data.corporations;
          this.loaded = true;
        }
      });
    },

    methods: {
      ...mapActions([
        'fetchUniverseAlliance',
        'fetchUniverseAllianceCorporations'
      ])
    }
  }
</script>
