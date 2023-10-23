<template>
  <v-app>
   <NavBar></NavBar>
    <v-main>
      <router-view/>
    </v-main>
  </v-app>
</template>

<script>

import Keycloak from '@/plugins/keycloak';
import NavBar from '@/components/NavBar.vue';

export default {
  name: 'App',
  components: {
    NavBar,
  },
  data: () => ({
  }),
  methods: {
    logout() {
      this.keycloak.logout({ redirectUri: 'http://localhost:3000' });
      this.keycloak = Keycloak();
    },
  },
};
</script>
