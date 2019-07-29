<template>
  <v-flex xs12>
    <v-card>
      <v-layout>
        <v-flex xs5>
          <v-img :src="icon" height="128px" contain></v-img>
        </v-flex>
        <v-flex xs7>
          <v-card-title primary-title>
            <div>
              <div class="headline">
                <router-link :to="{ name: 'universe_corporation', params: { id: id }}">
                  {{ name }}
                </router-link>
              </div>
              <div>({{ ticker }})</div>
              <div>Founded in {{ date_founded }}</div>
            </div>
          </v-card-title>
        </v-flex>
      </v-layout>
      <v-divider></v-divider>
      <v-card-actions>
        <v-btn text elevation="1">
          <router-link :to="{ name: 'universe_corporation', params: { id: id }}">
            Info
          </router-link>
        </v-btn>
        <v-spacer></v-spacer>
        <v-btn text elevation="1">
          <router-link :to="{ name: 'universe_corporation_characters', params: { id: id }}">
            Characters ({{ member_count }})
          </router-link>
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
            'ticker',
            'date_founded',
            'member_count']
  }
</script>
