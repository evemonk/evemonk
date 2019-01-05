<template>
  <div id="alliance">
    <v-card>
      <v-container fluid grid-list-lg>
        <v-layout row wrap>
          <v-flex xs12>
            <v-card dark>
              <v-layout>
                <v-flex xs5>
                  <v-img :src="alliance.icon" height="128px" contain></v-img>
                </v-flex>
                <v-flex xs7>
                  <v-card-title primary-title>
                    <div>
                      <div class="headline">{{ alliance.name }}</div>
                      <div>({{ alliance.ticker }})</div>
                      <div>Founded in {{ alliance.date_founded }}</div>
                    </div>
                  </v-card-title>
                </v-flex>
              </v-layout>
              <v-divider light></v-divider>
              <v-card-actions>
                <v-btn color="info">Corporations ({{ alliance.corporations_count }})</v-btn>
                <v-spacer></v-spacer>
                <v-btn color="info">Characters ({{ alliance.characters_count }})</v-btn>
              </v-card-actions>
            </v-card>
          </v-flex>

        </v-layout>
      </v-container>
    </v-card>

  </div>
</template>

<script>
  import { mapActions } from 'vuex';

  export default {
    data () {
      return {
        alliance: {}
      }
    },

    created () {
      let id = this.$route.params.id;

      this.fetchAlliance(id).then(response => {
        if (response.status === 200) {
          this.alliance = response.data.alliance;
        }
      });
    },

    methods: {
      ...mapActions({
        'fetchAlliance': 'fetchAlliance'
      })
    }
  }
</script>
