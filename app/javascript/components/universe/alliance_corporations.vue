<template>
  <div id="alliance_corporations">
    <vue-headful :title="title" />

    <v-breadcrumbs :items="breadcrumbs">
      <v-icon slot="divider">mdi-chevron-right</v-icon>
    </v-breadcrumbs>

    <v-progress-linear :indeterminate="true" v-if="!loaded"></v-progress-linear>

    <v-pagination v-model="current_page" :length="total_pages" v-if="loaded"></v-pagination>

      <v-card v-if="loaded">
        <v-container fluid grid-list-lg>
          <v-layout row wrap>
            <corporation-item v-for="corporation in corporations"
                              v-bind:key="corporation.id"
                              v-bind="corporation">
            </corporation-item>
          </v-layout>
        </v-container>
      </v-card>

      <v-pagination v-model="current_page" :length="total_pages" v-if="loaded"></v-pagination>
  </div>
</template>

<script>
  import { mapActions } from 'vuex';

  import CorporationItem from './corporation-item.vue';

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

    components: {
      'corporation-item': CorporationItem,
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
