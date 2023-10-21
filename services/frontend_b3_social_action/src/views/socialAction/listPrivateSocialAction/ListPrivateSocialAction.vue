<template>
  <v-container>
    <v-row
      class="mb-4" align="center"
      align-content="center"
      justify="center"
    >
      <v-col cols="12">
        <v-alert
          class="multi-line"
          v-model="dialogDeleteFeedback.state"
          dense
          dismissible
          :color="dialogDeleteFeedback.color"
          :type="dialogDeleteFeedback.type"
          prominent
          border="left"
          transition="scale-transition"
        >
          {{ dialogDeleteFeedback.message }}
        </v-alert>
      </v-col>

    </v-row>
    <v-row  align="center"  align-content="center" justify="center">
      <v-col >
        <v-card class="ml-8 mr-8 pr-4 pl-4">
          <v-card-title>
            <v-text-field
              class="mr-2"
              v-model="search"
              prepend-icon="mdi-magnify"
              label="Search"
              single-line
              hide-details
            ></v-text-field>
            <v-btn outlined>Buscar</v-btn>
          </v-card-title>
          <v-data-table
            :headers="headers"
            :items="activities"
            class="elevation-1"
            :search="search"
            :loading="loading"
            :server-items-length="total"
            :options.sync="options"
            loading-text="Carregando... Por Favor Espere"
            @pagination="onPageChange"
          >
            <template v-slot:top>
              <v-btn
                class="mt-2 mb-2"
                outlined
                @click="$router.push({ name: 'ActivityCreate' })">
                Criar Atividade
              </v-btn>
            </template>
            <template v-slot:no-data>
              Nenhum dados encontrado
            </template>
            <template  v-slot:[`item.actions`]="{ item }">
              <v-icon
                @click="toDetailPage(item)"
                small
                class="mr-2">
                mdi-eye
              </v-icon>
              <v-icon
                small
                class="mr-2"
                @click="editItem(item)"
              >
                mdi-pencil
              </v-icon>
              <v-icon
                small
                @click="deleteItem(item)"
              >
                mdi-delete
              </v-icon>
            </template>

          </v-data-table>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>

import { SocialActionRepository } from '@/repository/SocialActionRepository';

export default {
  name: 'ListSocialAction',
  data: () => ({
    dialogDeleteFeedback: {
      state: false,
      message: '',
      type: 'warning',
      color: 'warning',
    },
    dialogDelete: false,
    activityToDelete: '',
    headers: [
      { text: 'name', value: 'name' },
      { text: 'status', value: 'status' },
      { text: 'quantidade de vagas', value: 'vacanciesQuantity' },
      { text: 'email de contato', value: 'emailContact' },
      { text: 'Actions', value: 'actions', sortable: false },
    ],
    search: '',
    total: 0,
    page: 1,
    totalPages: 2,
    loading: false,
    options: {},
    activities: [],
    itemsPerPage: 10,
  }),
  methods: {
    async onPageChange(options) {
      // this.loading = true;
      // const activitiesData = await listActivitiesService(options.page, options.itemsPerPage);
      // this.activities = [...activitiesData.data];
      // this.options.page = activitiesData.current_page;
      // this.options.itemsPerPage = activitiesData.data.length;
      // this.loading = false;
    },
    toDetailPage(item) {
      this.$router.push({ name: 'DetailActivity', params: { id: item.id } });
    },
    editItem(item) {
      this.$router.push({ name: 'UpdateSocialActionView', params: { id: item.id } });
    },
    deleteItem(item) {
      this.activityToDelete = item;
      this.dialogDelete = true;
    },
    async deleteItemConfirm() {
      // if (this.activityToDelete === null) {
      //   return;
      // }
      // const { result, data } = await DeleteActivityService({
      //   activityID: this.activityToDelete.id,
      // });
      // this.dialogDelete = false;
      // if (result === true) {
      //   this.activities = this.activities.filter(
      //     (el) => el.id !== this.activityToDelete.id,
      //   );
      //   this.dialogDeleteFeedback.state = true;
      //   this.dialogDeleteFeedback.type = 'success';
      //   this.dialogDeleteFeedback.color = 'green';
      //   this.dialogDeleteFeedback.message = data;
      // } else {
      //   this.dialogDeleteFeedback.state = true;
      //   this.dialogDeleteFeedback.type = 'warning';
      //   this.dialogDeleteFeedback.color = 'warning';
      //   this.dialogDeleteFeedback.message = formatBackendResponse(data);
      // }
    },
  },
  async beforeMount() {
    this.loading = true;
    const repository = new SocialActionRepository();
    const data = await repository.listPrivate(0, 9);
    this.page = data.pageable.pageNumber;
    this.total = data.pageable.totalPages;
    // this.data = [...data.content];
    this.activities = [...data.content];
    this.loading = false;
  },
};
</script>

<style scoped>
.background {
  background-color: #E3F2FD;
}
</style>
