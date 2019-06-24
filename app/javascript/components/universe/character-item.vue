<template>
  <v-flex xs12>
    <v-card dark>
      <v-layout>
        <v-flex xs5>
          <v-img :src="icon" height="128px" contain></v-img>
        </v-flex>
        <v-flex xs7>
          <v-card-title primary-title>
            <div>
              <div class="headline">{{ name }}</div>
              <template v-if="corporation && alliance">
                <div>{{ corporation.name }} / {{ alliance.name }}</div>
              </template>
              <template v-else-if="corporation">
                <div>{{ corporation.name }}</div>
              </template>
              <template v-else-if="alliance">
                <div>{{ alliance.name }}</div>
              </template>
              <div>Birthday {{ birthday }}</div>
            </div>
          </v-card-title>
        </v-flex>
      </v-layout>
      <v-divider light></v-divider>
      <!-- <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn color="info">
          <router-link :to="{ name: 'universe_character', params: { id: id }}">
            More
          </router-link>
        </v-btn>
      </v-card-actions> -->
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
