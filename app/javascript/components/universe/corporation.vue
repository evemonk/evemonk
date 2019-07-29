<template>
  <div id="corporation">
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
      <v-flex xs12>
        <v-card>
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
          <v-divider></v-divider>
          <v-card-actions>
            <v-btn color="info">
              <router-link :to="{ name: 'universe_corporation_characters', params: { id: corporation.id }}">
                Characters ({{ corporation.member_count }})
              </router-link>
            </v-btn>
            <v-spacer></v-spacer>
            <v-btn color="info" v-if="corporation.ceo">
              <router-link :to="{ name: 'universe_character', params: { id: corporation.ceo.id }}">CEO</router-link>
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-flex>
    </template>
  </div>
</template>

<script>
  import { mapActions } from 'vuex';

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
        corporation: {},
        breadcrumbs: [
          {
            text: 'Home',
            to: { name: 'welcome' },
            exact: true
          },
          {
            text: 'Corporations',
            to: { name: 'universe_corporations' },
            exact: true
          }
        ]
      }
    },

    created () {
      let id = this.$route.params.id;

      this.fetchUniverseCorporation(id).then(response => {
        if (response.status === 200) {
          let corporation = response.data.corporation;

          this.corporation = corporation;
          this.loaded = true;
          this.loading = false;

          this.breadcrumbs.push({
            text: corporation.name,
            to: {
              name: 'universe_corporation',
              params: {
                id: corporation.id
              }
            },
            exact: true,
            disabled: true
          });

          this.headful.title = `«${corporation.name}» | EveMonk: EveOnline management suite`;
          this.headful.description = corporation.description;
          this.headful.image = corporation.icon;
          this.headful.url = `https://evemonk/universe/corporations/${corporation.id}`;
        } else {
          this.loading = false;
          this.loaded = false;
          this.error = true;
        }
      });
    },

    methods: {
      ...mapActions([
        'fetchUniverseCorporation'
      ])
    }
  }
</script>
