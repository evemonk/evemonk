<template>
  <header id="header">
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
      <a class="navbar-brand" href="#">EveMonk</a>

      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav">
          <li class="nav-item active">
            <!--<a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>-->
            <router-link class="nav-link" to="/">Home</router-link>
          </li>

          <li class="nav-item" v-if="!isAuthenticated">
            <!--<a class="nav-link" href="#">Features</a>-->
            <router-link class="nav-link" to="/sign_up">Sign Up</router-link>
          </li>

          <li class="nav-item" v-if="!isAuthenticated">
            <router-link class="nav-link" to="/sign_in">Sign In</router-link>
          </li>

          <li class="nav-item" v-if="isAuthenticated">
            <a class="nav-link" href="/sign_out" @click.prevent="signOut">Sign Out</a>
          </li>

          <li class="nav-item" v-if="isAuthenticated">
            <router-link class="nav-link" to="/profile">Profile</router-link>
          </li>

          <li class="nav-item" v-if="isAuthenticated">
            <router-link class="nav-link" to="/characters">Characters</router-link>
          </li>

          <li class="nav-item">
            <!--<a class="nav-link" href="#">Pricing</a>-->
            <router-link class="nav-link" to="/db/alliances">Alliances</router-link>
          </li>

          <li class="nav-item">
            <a class="nav-link disabled" href="#">Disabled</a>
          </li>
        </ul>
      </div>
    </nav>
  </header>
</template>

<script>
  import { mapGetters, mapActions } from 'vuex';

  export default {
    computed: {
      ...mapGetters([
        'isAuthenticated'
      ])
    },

    methods: {
      ...mapActions([
        'signOut'
      ])
    }
  }
</script>
