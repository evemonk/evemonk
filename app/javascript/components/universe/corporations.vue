<template>
  <div id="corporations">
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
                        <router-link :to="{ name: 'universe_corporation', params: { id: corporation.id }}">
                          {{ corporation.name }}
                        </router-link>
                      </div>
                      <div>({{ corporation.ticker }})</div>
                      <div>Founded in {{ corporation.date_founded }}</div>
                    </div>
                  </v-card-title>
                </v-flex>
              </v-layout>
              <v-divider light></v-divider>
              <v-card-actions>
                <!--<v-btn color="info">-->
                  <!--<router-link :to="{ name: 'universe_alliance_corporations', params: { id: alliance.id }}">-->
                    <!--Corporations ({{ alliance.corporations_count }})-->
                  <!--</router-link>-->
                <!--</v-btn>-->
                <v-spacer></v-spacer>
                <v-btn color="info">
                  <router-link :to="{ name: 'universe_corporation_characters', params: { id: corporation.id }}">
                    Characters ({{ corporation.member_count }})
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

    watch: {},

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
          console.log(this.corporations);
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
