<template>
  <v-container style="align-items: start" class="fill-height">
    <v-row justify="center" align="start">
      <v-col cols="12" class="seila">
        <v-alert
          class="multi-line"
          v-model="showAlert"
          dense
          dismissible
          :color="alert.color"
          :type="alert.type"
          prominent
          border="left"
          transition="scale-transition"
        >
          {{ alert.message }}
        </v-alert>
      </v-col>
    </v-row>
    <v-row >
      <v-col cols="12">
        <v-card  :loading="showLoading" elevation="10">
          <v-container  fluid>
            <v-row class="mb-2" justify="center">
              <v-col cols="auto">
                <v-container  style="font-size: 23px">
                  Criar Ação Social
                </v-container>
              </v-col>
            </v-row>
            <Form type="create"
                  @dataCreation="handleEvent"
                  @requestSend="showLoading = !showLoading"/>
          </v-container>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import Form from '../components/FormSocialAction.vue';

export default {
  components: {
    Form,
  },
  data: () => ({
    showAlert: false,
    showLoading: false,
    alert: {
      color: '',
      type: '',
      message: '',
    },
  }),
  name: 'SocialActionCreate',
  methods: {
    handleEvent(dataCreateInBackend) {
      this.showAlert = true;
      const result = dataCreateInBackend;
      if (result) {
        this.alert.type = 'success';
        this.alert.color = 'green';
        this.alert.message = 'Ação social criada com sucesso';
      } else {
        this.alert.type = 'warning';
        this.alert.color = 'warning';
        this.alert.message = 'Erro ao criar ação social';
      }
      if (result) {
        setTimeout(() => {
          this.showAlert = false;
          this.$router.push({ name: 'ListSocialActionView' });
        }, 3000);
      }
    },
  },
};
</script>

<style scoped>
.multi-line {
  white-space: pre-line;
}
</style>
