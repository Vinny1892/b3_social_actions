<template>
  <v-btn @click="$router.back()" color="primary"  outlined data-test-button>
    Voltar
  </v-btn>
</template>

<script>
export default {
  name: 'ButtonBack',
};
</script>

<style scaoped>

</style>
