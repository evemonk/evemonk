<template>
  <div id="alliances">
    <h1>Alliances</h1>

    <h1>Current page {{ current_page }}</h1>

    <v-pagination v-model="current_page" :length="total_pages"></v-pagination>

    <table id="alliances-list">
      <thead>
        <th>ID</th>
        <th>&nbsp;</th>
        <th>Name</th>
        <th>Corps count</th>
        <th>Members count</th>
      </thead>
      <tr v-for="alliance in alliances" :key="alliance.id">
          <td>{{ alliance.id }}</td>
          <td><img :src="alliance.icon" height="64" width="64"></td>
          <td>{{ alliance.name }}</td>
          <td>{{ alliance.corporations_count }}</td>
          <td>{{ alliance.characters_count }}</td>
        </tr>
      </table>

      <v-pagination v-model="current_page" :length="total_pages"></v-pagination>
    </div>
</template>

<script>
  import { mapActions } from 'vuex';

  export default {
    data () {
      return {
        alliances: [],
        current_page: 1,
        total_count: null,
        total_pages: null
      }
    },

    watch: {
      current_page: function (page) {
        this.fetchAlliances(page).then(response => {
          if (response.status === 200) {
            this.total_count = response.data.total_count;
            this.total_pages = response.data.total_pages;
            this.alliances = response.data.alliances;
          }
        })
      }
    },

    created () {
      this.fetchAlliances(this.current_page).then(response => {
        if (response.status === 200) {
          this.total_count = response.data.total_count;
          this.total_pages = response.data.total_pages;
          this.alliances = response.data.alliances;
        }
      });
    },

    methods: {
      ...mapActions({
        'fetchAlliances': 'fetchAlliances'
      })
    }
  }
</script>
