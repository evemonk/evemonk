<template>
  <div id="type">
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
        type: {},
        breadcrumbs: [
          {
            text: 'Home',
            to: { name: 'welcome' },
            exact: true
          },
          {
            text: 'Types',
            to: { name: 'universe_types' },
            exact: true
          }
        ]
      }
    },

    created () {
      let id = this.$route.params.id;

      this.fetchUniverseType(id).then(response => {
        if (response.status === 200) {
          let type = response.data;

          this.type = type;
          this.loaded = true;
          this.loading = false;

          this.breadcrumbs.push({
            text: type.name,
            to: {
              name: 'universe_type',
              params: {
                id: type.id
              }
            },
            exact: true,
            disabled: true
          });

          this.headful.title = `«${type.name}» | EveMonk: EveOnline management suite`;
          this.headful.description = type.description;
          // this.headful.image = corporation.icon;
          this.headful.url = `https://evemonk/universe/types/${type.id}`;
        } else {
          this.loading = false;
          this.loaded = false;
          this.error = true;
        }
      });
    },

    methods: {
      ...mapActions([
        'fetchUniverseType'
      ])
    }
  }
</script>
