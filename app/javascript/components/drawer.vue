<template>
  <v-navigation-drawer app
                       v-model="drawer"
                       absolute
                       temporary>
    <v-toolbar flat class="transparent">
      <v-list>
        <v-list-tile avatar>
          <v-list-tile-avatar>
            <img src="https://randomuser.me/api/portraits/men/85.jpg">
          </v-list-tile-avatar>

          <v-list-tile-content>
            <v-list-tile-title>John Snow</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>
      </v-list>
    </v-toolbar>

    <v-list dense>
      <template v-if="!isAuthenticated">
        <v-divider></v-divider>

        <v-list-tile to="/sign_in">
          <v-list-tile-action>
            <v-icon>folder</v-icon>
          </v-list-tile-action>

          <v-list-tile-content>
            <v-list-tile-title>Sign in</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>
      </template>

      <template v-if="!isAuthenticated">
        <v-divider></v-divider>

        <v-list-tile to="/sign_up">
          <v-list-tile-action>
            <v-icon>folder</v-icon>
          </v-list-tile-action>

          <v-list-tile-content>
            <v-list-tile-title>Sign up</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>
      </template>

      <template v-if="isAuthenticated">
        <v-divider></v-divider>

        <v-list-tile to="/profile">
          <v-list-tile-action>
            <v-icon>folder</v-icon>
          </v-list-tile-action>

          <v-list-tile-content>
            <v-list-tile-title>Profile</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>
      </template>

      <template v-if="isAuthenticated">
        <v-divider></v-divider>

        <v-list-tile to="/characters" v-if="isAuthenticated">
          <v-list-tile-action>
            <v-icon>folder</v-icon>
          </v-list-tile-action>

          <v-list-tile-content>
            <v-list-tile-title>Characters</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>
      </template>

      <v-divider></v-divider>

      <v-list-tile to="/db/alliances">
        <v-list-tile-action>
          <v-icon>folder</v-icon>
        </v-list-tile-action>

        <v-list-tile-content>
          <v-list-tile-title>Alliances</v-list-tile-title>
        </v-list-tile-content>
      </v-list-tile>

      <template v-if="isAuthenticated">
        <v-divider></v-divider>

        <v-list-tile to="/sign_out">
          <v-list-tile-action>
            <v-icon>folder</v-icon>
          </v-list-tile-action>

          <v-list-tile-content>
            <v-list-tile-title>Sign out</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>
      </template>

      <v-divider></v-divider>
    </v-list>

  </v-navigation-drawer>
</template>

<script>
  import { mapGetters } from 'vuex';

  import store from '../store';

  export default {
    computed: {
      ...mapGetters([
        'isAuthenticated'
      ]),

      drawer: {
        get() {
          return this.getDrawer();
        },

        set(value) {
          store.commit('setDrawer', value);
        }
      }
    },

    methods: {
      ...mapGetters([
        'getDrawer'
      ])
    }
  }
</script>
