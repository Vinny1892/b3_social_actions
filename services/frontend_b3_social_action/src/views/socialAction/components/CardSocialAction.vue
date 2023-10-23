<template>
  <v-card @click="$router.push({name: 'DetailSocialActionView', params: {id: socialAction.id}})" >
    <v-card-text>
      <v-row>
        <v-col cols="8">
          <v-card-title>
            {{ socialAction.name }}
          </v-card-title>

        </v-col>
        <v-col>
          <v-list-item-avatar
            tile
            size="80"
            color="grey"
          ></v-list-item-avatar>
        </v-col>
      </v-row>

      <div class="grey--text ml-4 mt-4">{{ this.socialAction.description }}</div>
    </v-card-text>

    <v-divider class="mx-4"></v-divider>
    <v-card-text>
      <v-chip-group column>
        <v-chip
          v-if="socialAction.dateInit !== null"
          color="blue darken-2"
          text-color="white"
        >{{
            `Data Inicio
            ${toDefaultDate(socialAction.dateInit)}`
          }}</v-chip>
        <v-chip
          v-if="socialAction.dateFinal !== null"

          text-color="white"
          color="blue darken-2"
        >{{
            ` Data Fim  ${toDefaultDate(socialAction.dateFinal)}`
          }}</v-chip>

        <v-chip
          v-if="socialAction.timeInit !== null"
          color="blue darken-2"
          text-color="white"
        >{{
            `Data Inicio
            ${toDefaultDate(new Date())}`
          }}</v-chip>
        <v-chip
          v-if="socialAction.timeFinal !== null"
          text-color="white"
          color="blue darken-2"
        >{{
            ` Data Fim  ${toDefaultDate(new Date())}`
          }}</v-chip>
      </v-chip-group>
    </v-card-text>

  </v-card>
</template>

<script>
export default {
  name: 'CardSocialAction',
  props: {
    socialAction: {
      type: Object,
      required: true,
    },
  },
  computed: {
    image() {
      return `${process.env.VUE_APP_BASE_ROOT_EVENT_IMAGE_FOLDER}/${this.socialAction.pathImage}`;
    },
  },
  methods: {
    toDefaultDate(isoDate) {
      const dateString = isoDate.toString();
      const date = dateString.substr(0, 10);
      const [year, month, day] = date.split('-');
      return `${day}/${month}/${year}`;
    },
  },
};
</script>

<style scoped>

</style>
