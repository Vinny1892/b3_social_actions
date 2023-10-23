<template>
  <v-container style="align-items: start" class="fill-height">
    <v-row justify="center" align="start">
      <v-col cols="12" class="seila">
        <v-alert
          v-model="alert.state"
          dense
          dismissible
          :color="alert.type"
          :type="alert.type"
          prominent
          border="left"
          transition="scale-transition"
        >
          {{ alert.content }}
        </v-alert>
      </v-col>
      <v-row justify="center" >
        <v-card >
          <v-card-title> Credenciamento da Sessão </v-card-title>
          <v-col v-if="video" cols="12">
            <v-container  class="container-video" >
              <qrcode-stream
                @init="init"
                @decode="registerPresence"
                @loaded="onLoaded"
              ></qrcode-stream>
            </v-container>
          </v-col>
          <v-col v-else cols="12"
                 class="container-video"
                 style="min-height: 405px; min-width: 524px">
            <v-container class="black lighten-1"
                         style="min-height: 357px;
                             min-width: 476px">
            </v-container>
          </v-col>
          <v-col>
            <v-card >
              <v-form class="px-5 pb-5" >
                <v-card-title tag="legend">Tentar Credenciar Sem Utilizar o QRCode</v-card-title>
                <v-card-actions>
                  <v-btn color="primary" @click="registerPresence()" > Credenciar </v-btn>
                  <ButtonBack/>
                </v-card-actions>
              </v-form>
            </v-card>
          </v-col>
        </v-card>
      </v-row>
    </v-row>
  </v-container>

</template>

<script>
import { QrcodeStream } from 'vue-qrcode-reader';
import ButtonBack from '@/components/ButtonBack.vue';

export default {
  name: 'RegisterPresenceView',
  components: {
    ButtonBack,
    QrcodeStream,
  },
  data: () => ({
    video: true,
    alert: {
      state: false,
      content: '',
      type: '',
    },
    showAlert: true,
    taskID: '',
    userID: null,
    result: false,
  }),
  methods: {
    async init(promise) {
      try {
        await promise;
        this.video = true;
        this.alert.state = false;
      } catch (e) {
        this.video = false;
        this.alert.type = 'warning';
        this.alert.content = 'Erro ao utilizar camera, verifique as permissoes';
        this.alert.state = true;
      }
    },
    async registerPresence(QRCodeSessionID) {
      this.userID = this.$store.getters['auth/getUser'].id;

      const { data, result } = {}; // request;
      if (result) {
        this.alert.type = 'success';
        this.alert.content = 'presença registrada com sucesso';
      } else {
        this.alert.type = 'warning';
        this.alert.content = 'erro ao registrar presença';
      }
      this.alert.state = true;
      if (result) {
        setTimeout(() => {
          this.showAlert = false;
          this.$router.push({ name: 'ListPublicSocialActionView' });
        }, 3000);
      }
    },
    onLoaded() {
      console.log('Ready to start scanning barcodes');
    },
  },
  async mounted() {
    this.taskID = this.$route.params.id;
  },
};
</script>

<style scoped>
.container-video {
  max-width: 500px;
  max-height: 400px;
}

</style>
