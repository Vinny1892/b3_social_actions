<template>
  <v-container  fluid class="fill-height" style="padding: 0px">
    <v-progress-linear
      v-show="loading"
      indeterminate
      color="yellow darken-2"
    ></v-progress-linear>
    <v-container
      class="fill-height"
      fluid
    >
      <v-row >
        <v-col sm="6" lg="4" v-for="socialAction in data" :key="socialAction.id" >
          <v-slide-x-transition>
            <CardSocialAction :social-action="socialAction" />
          </v-slide-x-transition>
        </v-col>
      </v-row>
      <v-row  justify="center" class="mt-8">
        <v-pagination
          total-visible="8"
          v-model="page"
          :length="totalPages"
          @input="onPageChange"
        ></v-pagination>
      </v-row>
    </v-container>
  </v-container>
</template>

<script>
import CardSocialAction from '@/views/socialAction/components/CardSocialAction.vue';
import api from '@/plugins/axios';
import { SocialActionRepository } from '@/repository/SocialActionRepository';

export default {
  components: { CardSocialAction },
  name: 'ListSocialAction',
  data: () => ({
    page: 1,
    totalPages: 2,
    loading: false,
    data: [],
  }),
  methods: {
    async onPageChange(value) {
      this.loading = true;
      // const eventsData = await listEventsDashboardService(value, 9);
      // this.events = [...eventsData.data];
      // this.page = eventsData.current_page;
      this.loading = false;
    },
  },
  async mounted() {
    const request = new SocialActionRepository();
    const dataRequest = await request.listPublic(0, 9);
    console.log(dataRequest);
    this.page = dataRequest.pageable.pageNumber;
    this.totalPages = dataRequest.pageable.totalPages;
    this.data = [...dataRequest.content];
  },
};
</script>

<style scoped>
.background {
  background-color: #E3F2FD;
}
</style>
