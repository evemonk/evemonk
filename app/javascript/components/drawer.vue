<template>
  <v-navigation-drawer app
                       v-model="drawer"
                       absolute>
    <v-toolbar flat class="transparent" v-if="false">
      <v-list>
        <v-list-item>
          <v-list-item-avatar>
            <img src="https://randomuser.me/api/portraits/men/85.jpg">
          </v-list-item-avatar>

          <v-list-item-content>
            <v-list-item-title>John Snow</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
      </v-list>

      <v-divider></v-divider>
    </v-toolbar>

    <v-list dense>
      <template v-if="!isAuthenticated">
        <v-list-item :to="{ name: 'sign_in' }">
          <v-list-item-action>
            <v-icon>mdi-folder</v-icon>
          </v-list-item-action>

          <v-list-item-content>
            <v-list-item-title>Sign in</v-list-item-title>
          </v-list-item-content>
        </v-list-item>

        <v-divider></v-divider>
      </template>

      <template v-if="!isAuthenticated">
        <v-list-item :to="{ name: 'sign_up' }">
          <v-list-item-action>
            <v-icon>mdi-folder</v-icon>
          </v-list-item-action>

          <v-list-item-content>
            <v-list-item-title>Sign up</v-list-item-title>
          </v-list-item-content>
        </v-list-item>

        <v-divider></v-divider>
      </template>

      <template v-if="isAuthenticated">
        <v-list-item :to="{ name: 'profile' }">
          <v-list-item-action>
            <v-icon>mdi-folder</v-icon>
          </v-list-item-action>

          <v-list-item-content>
            <v-list-item-title>Profile</v-list-item-title>
          </v-list-item-content>
        </v-list-item>

        <v-divider></v-divider>
      </template>

      <template v-if="isAuthenticated">
        <v-list-item :to="{ name: 'characters' }" v-if="isAuthenticated">
          <v-list-item-action>
            <v-icon>mdi-folder</v-icon>
          </v-list-item-action>

          <v-list-item-content>
            <v-list-item-title>Characters</v-list-item-title>
          </v-list-item-content>
        </v-list-item>

        <v-divider></v-divider>
      </template>

      <template v-if="isAuthenticated">
        <v-list-item :to="{ name: 'lpstore' }" v-if="isAuthenticated">
          <v-list-item-action>
            <v-icon>mdi-folder</v-icon>
          </v-list-item-action>

          <v-list-item-content>
            <v-list-item-title>LP Store</v-list-item-title>
          </v-list-item-content>
        </v-list-item>

        <v-divider></v-divider>
      </template>

      <v-list-item :to="{ name: 'universe_alliances' }">
        <v-list-item-action>
          <v-icon>mdi-folder</v-icon>
        </v-list-item-action>

        <v-list-item-content>
          <v-list-item-title>Alliances</v-list-item-title>
        </v-list-item-content>
      </v-list-item>

      <v-divider></v-divider>

      <v-list-item :to="{ name: 'universe_corporations' }">
        <v-list-item-action>
          <v-icon>mdi-folder</v-icon>
        </v-list-item-action>

        <v-list-item-content>
          <v-list-item-title>Corporations</v-list-item-title>
        </v-list-item-content>
      </v-list-item>

      <v-divider></v-divider>

      <v-list-item :to="{ name: 'universe_characters' }">
        <v-list-item-action>
          <v-icon>mdi-folder</v-icon>
        </v-list-item-action>

        <v-list-item-content>
          <v-list-item-title>Characters</v-list-item-title>
        </v-list-item-content>
      </v-list-item>

      <v-divider></v-divider>

      <template v-if="isAuthenticated">
        <v-list-item :to="{ name: 'sign_out' }">
          <v-list-item-action>
            <v-icon>mdi-folder</v-icon>
          </v-list-item-action>

          <v-list-item-content>
            <v-list-item-title>Sign out</v-list-item-title>
          </v-list-item-content>
        </v-list-item>

        <v-divider></v-divider>
      </template>
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
          store.commit('SET_DRAWER', value);
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
