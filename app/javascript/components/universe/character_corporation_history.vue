<template>
  <div id="character_corporation_history">
    <template v-if="loaded">
      <v-card-title>
        Corporations History ({{ total_count }})
        <v-spacer></v-spacer>
        <v-text-field v-model="search"
                      append-icon="search"
                      label="Search"
                      single-line
                      hide-details>
        </v-text-field>
      </v-card-title>

      <v-data-table :headers="headers"
                    :items="history"
                    :search="search"
                    hide-actions
                    dark>
        <template v-slot:items="props">
          <td>
            <router-link :to="{ name: 'universe_corporation',
                                params: { id: props.item.corporation.id }}">
              {{ props.item.corporation.name }}
            </router-link>
          </td>
          <td class="text-xs-right">{{ props.item.start_date }}</td>
        </template>

        <template v-slot:no-results>
          <v-alert :value="true" color="error" icon="warning">
            Your search for "{{ search }}" found no results.
          </v-alert>
        </template>
      </v-data-table>
    </template>
  </div>
</template>

<script>
  import { mapActions } from 'vuex';

  export default {
    props: ['id'],

    data () {
      return {
        loading: true,
        loaded: false,
        error: false,
        current_page: 1,
        total_count: null,
        total_pages: null,
        history: [],
        headers: [
          { text: 'Corporation', value: 'corporation.name', sortable: false },
          { text: 'Joined at', value: 'start_date', sortable: false }
        ],
        search: '',
      }
    },

    watch: {
      current_page: function (page) {
        this.fetchUniverseCharacterCorporationsHistory({ id: this.id, page: page }).then(response => {
          if (response.status === 200) {
            this.history.push(...response.data.history);

            if (this.current_page < this.total_pages) {
              this.current_page++;
            } else {
              this.loaded = true;
              this.loading = false;
            }
          } else {
            this.loading = false;
            this.loaded = false;
            this.error = true;
          }
        });
      }
    },

    created () {
      this.fetchUniverseCharacterCorporationsHistory({ id: this.id, page: this.current_page }).then(response => {
        if (response.status === 200) {
          this.history.push(...response.data.history);
          this.total_count = response.data.total_count;
          this.total_pages = response.data.total_pages;

          if (this.current_page < this.total_pages) {
            this.current_page++;
          } else {
            this.loaded = true;
            this.loading = false;
          }
        } else {
          this.loading = false;
          this.loaded = false;
          this.error = true;
        }
      });
    },

    methods: {
      ...mapActions([
        'fetchUniverseCharacterCorporationsHistory'
      ])
    }
  }
</script>