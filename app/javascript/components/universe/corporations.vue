<template>
  <div id="corporations">
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
        title: 'Corporations | EveMonk: EveOnline management suite',
        loaded: false,
        corporations: [],
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
            text: 'Corporations',
            to: { name: 'universe_corporations' },
            exact: true,
            disabled: true
          }
        ]
      }
    },

    components: {
      'corporation-item': CorporationItem,
    },

    watch: {
      current_page: function (page) {
        this.fetchUniverseCorporations(page).then(response => {
          if (response.status === 200) {
            this.total_count = response.data.total_count;
            this.total_pages = response.data.total_pages;
            this.corporations = response.data.corporations;

            this.$router.push({ name: 'universe_corporations', query: { page: page } });
          }
        });
      },
    },

    created () {
      // console.log('created');

      let page = this.$route.query.page;

      // console.log(page);

      if (page !== undefined) {
        this.current_page = parseInt(page);
      }

      this.fetchUniverseCorporations(this.current_page).then(response => {
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
        'fetchUniverseCorporations'
      ])
    }
  }
</script>
