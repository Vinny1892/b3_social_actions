<template>
  <v-container>
    <v-card
      :loading="loading"
      class="mx-auto my-12"
    >
      <v-row>
        <v-col cols="12" sm="6">
<!--          <v-img-->
<!--            class="ml-4"-->
<!--            v-if="event.pathImage !== null"-->
<!--            height="250"-->
<!--            width="320"-->
<!--            :src="image"-->
<!--          ></v-img>-->
        </v-col>
        <v-col cols="12" sm="6">
          <v-card-title class="text-capitalize">{{ socialAction.name }}</v-card-title>

          <v-card-text>
            <v-row>
              <v-col>
                <div class="text-subtitle-1 mb-4">
                  {{ socialAction.emailContact }}
                </div>
                <div class="text-subtitle-2"> {{ socialAction.description }}</div>
              </v-col>
            </v-row>
            <v-divider class="my-4"></v-divider>
            <div class="text-md-subtitle-1">Categorias</div>
            <v-chip-group
              column
            >
              <v-chip
                v-for="category in socialAction.categories"
                :key="category.id">
                {{category.name}}
              </v-chip>

            </v-chip-group>

          </v-card-text>
        </v-col>
      </v-row>
      <v-divider class="my-4"></v-divider>

      <v-card-text>
        <div class="text-md-subtitle-1"> Data de Inicio/Fim </div>
        <v-chip-group
          column
        >
          <v-chip>
            {{ formatDate(socialAction.dateInit)}}
          </v-chip>
          <v-chip>
            {{ formatDate(socialAction.dateFinal) }}
          </v-chip>
        </v-chip-group>
        <div v-if="socialAction.timeInit !== null || socialAction.timeFinal !== null" >
          <div class="text-md-subtitle-1"> Hora de Inicio/Fim </div>
          <v-chip-group
            column
          >
            <v-chip>
              {{ socialAction.timeInit }}
            </v-chip>
            <v-chip>
              {{ socialAction.timeFinal }}
            </v-chip>
          </v-chip-group>
        </div>

      </v-card-text>

<!--      <v-card-text-->
<!--        v-if="event.socialMedia !== null"-->
<!--      >-->
<!--        <div class="text-md-subtitle-1">Midias Sociais </div>-->
<!--        <v-chip-group-->
<!--          column-->
<!--        >-->
<!--          <v-chip-->
<!--            v-for="preRequisite in event.socialMedia.split(',')"-->
<!--            :key="preRequisite">-->
<!--            {{preRequisite}}-->
<!--          </v-chip>-->
<!--        </v-chip-group>-->
<!--      </v-card-text>-->

      <v-divider v-if="socialAction.tasks.length !== 0" class="mx-4"></v-divider>

      <v-card-title v-if="socialAction.tasks.length !== 0" >Tarefas</v-card-title>

      <v-card-text>
        <v-list  v-if="socialAction.tasks.length !== 0">
          <v-list-group
            no-action
            v-for="task in socialAction.tasks "
            :key="task.id"
          >
            <template v-slot:activator>
              <v-list-item>
                <v-list-item-content>
                  <v-list-item-title
                    class="text-capitalize"
                    v-text="task.name"
                  >
                  </v-list-item-title>
                </v-list-item-content>
              </v-list-item>

            </template>
            <v-list>
              <ItemSubList
                v-if="task.description !== null"
                label="Descrição"
                :unsetTruncateText="true"
                :value="task.description"></ItemSubList>
              <ItemSubList
                v-if="task.preRequisites !== null"
                label="Pré-Requisitos"
                :value="task.preRequisites"></ItemSubList>
            </v-list>
            <v-card-actions>
              <v-btn
                color="primary"
                outlined
                @click="alert('inscrição feita')">
                Inscreva-se
              </v-btn>
            </v-card-actions>
<!--            <v-list >-->
<!--              <v-list v-for="session in activity.sessions" :key="session.id">-->
<!--                <v-card elevation="0"  style="border: 1px solid grey">-->
<!--                  <ItemSubList-->
<!--                    :unsetTruncateText="true"-->
<!--                    label="Descrição"-->
<!--                    :value="session.description"></ItemSubList>-->
<!--                  <ItemSubList label="Status" :value="StatusSession.get(session.status.
name)">-->
<!--                  </ItemSubList>-->
<!--                  <div v-if="session.dateInit !== null && session.dateFinal !== null">-->
<!--                    <ItemSubList label="data inicio" :value="formatDate(session.dateInit)" >-->
<!--                    </ItemSubList>-->
<!--                    <ItemSubList label="hora inicio" :value="formatTime(session.dateInit)" >-->
<!--                    </ItemSubList>-->
<!--                    <ItemSubList label="data Fim" :value="formatDate(session.dateFinal)" >-->
<!--                    </ItemSubList>-->
<!--                    <ItemSubList label="hora Fim" :value="formatTime(session.dateFinal)" >-->
<!--                    </ItemSubList>-->
<!--                  </div>-->
<!--                  <div  v-else>-->
<!--                    <ItemSubList value="não está definido" label="data/hora final"/>-->
<!--                    <ItemSubList value="não está definido" label="data/hora inicio"/>-->

<!--                  </div>-->

<!--                  <v-card-actions>-->
<!--                    <v-btn-->
<!--                      outlined-->
<!--                      @click="toRegisterPresencePage(session.id)"-->
<!--                      v-if="session.formAccreditation.name === Fo
rmAccreditation.showQRCODE.name"-->
<!--                    >-->
<!--                      credenciar-->
<!--                    </v-btn>-->
<!--                  </v-card-actions>-->
<!--                </v-card>-->
<!--              </v-list>-->
<!--            </v-list>-->
          </v-list-group>
        </v-list>
        <Modal
          v-model="showDialog"
          :content="dataDialog.content"
          :title="dataDialog.title"
        ></Modal>
        <ButtonBack class="mt-4"/>
      </v-card-text>
    </v-card>
  </v-container>
</template>

<script>

import ButtonBack from '@/components/ButtonBack.vue';
import { SocialActionRepository } from '@/repository/SocialActionRepository';
import api from '@/plugins/axios';

export default {
  name: 'DetailEvent',
  components: { ButtonBack },
  data: () => ({
    loading: true,
    showDialog: false,
    dataDialog: {
      title: '',
      content: '',
    },
    socialAction: {

    },
  }),
  methods: {
    formatDate(isoDate) {
      const dateString = isoDate.toString();
      const date = dateString.substr(0, 10);
      const [year, month, day] = date.split('-');
      return `${day}/${month}/${year}`;
    },
    // async registerSubscription(activity) {
    //   if (this.$store.getters['auth/getUser'].logged === false) {
    //     await this.$router.push({ name: 'Login' });
    //     return;
    //   }
    //   const { result, data } = await RegisterSubscriptionService(
    //     {
    //       activity_id: activity.id,
    //     },
    //   );
    //   this.dataDialog.title = `Inscrição na atividade ${activity.name} `;
    //   this.dataDialog.content = formatBackendResponse(data);
    //   this.showDialog = true;
    // },
    // formatDate(date) {
    //   return formatDateHelper(date);
    // },
    // async toRegisterPresencePage(sessionID) {
    //   if (this.$store.state.auth.user.logged === false) {
    //     await this.$router.push(({ name: 'Login' }));
    //     return;
    //   }
    //   await this.$router.push({ name: 'RegisterPresence', params: { id: sessionID } });
    // },
  },
  async mounted() {
    const { id } = this.$route.params;
    const repository = new SocialActionRepository(api);
    const data = await repository.get(id);
    console.log(data);
    this.socialAction = { ...data };
    this.loading = false;
  },
};
</script>

<style scoped>

</style>
