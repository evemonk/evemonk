<template>
  <div id="alliances">
    <vue-headful :title="headful.title"
                 :url="headful.url" />

    <v-breadcrumbs :items="breadcrumbs">
      <v-icon slot="divider">mdi-chevron-right</v-icon>
    </v-breadcrumbs>

    <template v-if="loading">
      <v-progress-linear :indeterminate="true"></v-progress-linear>
    </template>

    <template v-if="loaded">
      <v-pagination v-model="current_page" :length="total_pages" v-if="loaded"></v-pagination>

      <v-card v-if="loaded">
        <v-container fluid grid-list-lg>
          <v-layout row wrap>
            <alliance-item v-for="alliance in alliances"
                           v-bind:key="alliance.id"
                           v-bind="alliance">
            </alliance-item>
          </v-layout>
        </v-container>
      </v-card>

      <v-pagination v-model="current_page" :length="total_pages" v-if="loaded"></v-pagination>
    </template>

    <template v-if="error">
      We're sorry, but something went wrong. Please, try again later.
    </template>
  </div>
</template>

<script>
  import { mapActions } from 'vuex';

  import AllianceItem from './alliance-item.vue';

  export default {
    data () {
      return {
        headful: {
          title: 'Alliances | EveMonk: EveOnline management suite',
          url: '',
        },
        loading: true,
        loaded: false,
        error: false,
        alliances: [],
        current_page: 1,
        total_count: null,
        total_pages: null,
        breadcrumbs: [
          {
            text: 'Home',
            to: { name: 'welcome' },
            exact: true
          },
          {
            text: 'Alliances',
            to: { name: 'universe_alliances' },
            exact: true,
            disabled: true
          }
        ]
      }
    },

    components: {
      'alliance-item': AllianceItem,
    },

    watch: {
      current_page: function (page) {
        this.fetchUniverseAlliances(page).then(response => {
          if (response.status === 200) {
            this.total_count = response.data.total_count;
            this.total_pages = response.data.total_pages;
            this.alliances = response.data.alliances;

            this.$router.push({ name: 'universe_alliances', query: { page: page } });
          }
        });
      },

      // '$route.query.page': function (page) {
      //   console.log('$route.query.page', page);
      //   console.log('Number.isInteger: ', Number.isInteger(page));
      //   if (page !== undefined && parseInt(page) !== this.current_page) {
      //     console.log('inside $route.query.page', page);
      //     this.current_page = parseInt(page);
      //   }
      // }
    },

    created () {
      let page = this.$route.query.page;

      if (page !== undefined) {
        this.current_page = parseInt(page);
      }

      this.fetchUniverseAlliances(this.current_page).then(response => {
        if (response.status === 200) {
          this.total_count = response.data.total_count;
          this.total_pages = response.data.total_pages;
          this.alliances = response.data.alliances;
          this.loaded = true;
          this.loading = false;
        } else {
          this.loading = false;
          this.loaded = false;
          this.error = true;
        }
      });
    },

    methods: {
      ...mapActions([
        'fetchUniverseAlliances'
      ])
    }
  }
</script>
