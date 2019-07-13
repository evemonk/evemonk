<template>
  <div id="character_corporation_history">
    <v-card-title>
      Corporations History
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
          <router-link :to="{ name: 'universe_corporation', params: { id: props.item.id }}">{{ props.item.name }}</router-link>
        </td>
        <td class="text-xs-right">{{ props.item.start_date }}</td>
      </template>

      <template v-slot:no-results>
        <v-alert :value="true" color="error" icon="warning">
          Your search for "{{ search }}" found no results.
        </v-alert>
      </template>
    </v-data-table>
  </div>
</template>

<script>
  import { mapActions } from 'vuex';

  export default {
    props: ['id'],

    created () {
      this.fetchUniverseCharacterCorporationsHistory({ id: id, page: '1' }).then(response => {
        
      });

    },

    methods: {
      ...mapActions([
        'fetchUniverseCharacterCorporationsHistory'
      ])
    }
  }
</script>