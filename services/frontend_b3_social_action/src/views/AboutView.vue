<template>
  <div class="about">
    <h1>This is an about page</h1>
    <div>
      {{ user.email }}
    </div>
  </div>
</template>
<script>

import Keycloak from '@/plugins/keycloak';

export default {
  name: 'HomeView',
  data: () => ({
    user: {},
  }),
  async mounted() {
    this.user = Keycloak().tokenParsed;
  },
};

</script>
