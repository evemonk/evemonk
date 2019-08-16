<template>
  <v-flex xs12>
    <v-card>
      <v-layout>
        <v-flex xs5>
          <v-img :src="icon.huge" height="128px" contain></v-img>
        </v-flex>
        <v-flex xs7>
          <v-card-title primary-title>
            <div>
              <div class="headline">
                <router-link :to="{ name: 'universe_character', params: { id: id }}">
                  {{ name }}
                </router-link>
              </div>

              <template v-if="corporation && alliance">
                <div>
                  <router-link :to="{ name: 'universe_corporation', params: { id: corporation.id }}">
                    {{ corporation.name }}
                  </router-link> /
                  <router-link :to="{ name: 'universe_alliance', params: { id: alliance.id }}">
                    {{ alliance.name }}
                  </router-link>
                </div>
              </template>

              <template v-else-if="corporation">
                <div>
                  <router-link :to="{ name: 'universe_corporation', params: { id: corporation.id }}">
                    {{ corporation.name }}
                  </router-link>
                </div>
              </template>

              <template v-else-if="alliance">
                <div>
                  <router-link :to="{ name: 'universe_alliance', params: { id: alliance.id }}">
                    {{ alliance.name }}
                  </router-link>
                </div>
              </template>

              <div>Birthday {{ birthday }}</div>
            </div>
          </v-card-title>
        </v-flex>
      </v-layout>
      <v-divider></v-divider>
      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn text elevation="1">
          <router-link :to="{ name: 'universe_character', params: { id: id }}">More</router-link>
        </v-btn>
      </v-card-actions>
    </v-card>
  </v-flex>
</template>

<script>
  export default {
    props: ['id',
            'icon',
            'name',
            'corporation',
            'alliance',
            'birthday']
  }
</script>
