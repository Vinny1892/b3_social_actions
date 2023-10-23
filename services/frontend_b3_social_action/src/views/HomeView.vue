<template>
  <hello-world />
</template>

<script>
import api from '@/plugins/axios';
import HelloWorld from '../components/HelloWorld.vue';

export default {
  name: 'HomeView',

  components: {
    HelloWorld,
  },

  async mounted() {
    const response = await api.get('social_actions/dac3b064-a1f2-41c1-80e2-aa6d3ad58f38');
    console.log(response);
  },
};
</script>
