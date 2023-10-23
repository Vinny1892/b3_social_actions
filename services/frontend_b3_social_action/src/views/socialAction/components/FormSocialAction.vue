<template>
  <v-form
    ref="form"
    @submit.prevent="submitForm"
  >
    <v-autocomplete
      :disabled="type === 'update'"
      label="Nome da Ong"
      :items="itemsOng"
      :search-input.sync="searchOngName"
      :loading="loadingAutoCompleteOngName"
      item-value="name"
      item-text="name"
      return-object
      v-model="socialAction.ong"
      outlined
    >
    </v-autocomplete>
    <v-text-field
      :error-messages="nameErrors"
      v-model="socialAction.name"
      outlined
      label="Nome*">
    </v-text-field>
    <v-text-field
      v-model="socialAction.paymentLink"
      outlined
      label="Link para pagamento (Usar para caso de ação social que contém doação)"
    >
    </v-text-field>
    <v-text-field
      :error-messages="emailContactErrors"
      v-model="socialAction.emailContact"
      outlined
      label="Email De Contato*">
    </v-text-field>
    <v-textarea
      v-model="socialAction.description"
      outlined
      rows="3"
      row-height="20"
      no-resize
      label="Descrição">
    </v-textarea>
    <v-select
      label="Status"
      outlined
      item-text="value"
      item-value="name"
      :items="['PUBLICO', 'PRIVADO']"
      v-model="socialAction.status"
    ></v-select>
<!--   DATE PICKER -->

    <v-menu
      ref="menuDateInit"
      v-model="menuDateInit"
      :close-on-content-click="false"
      transition="scale-transition"
      offset-y
      max-width="290px"
      min-width="auto"
    >
      <template v-slot:activator="{ on, attrs }">
        <v-text-field
          v-model="dateInitFormatted"
          label="Data de Inicio"
          outlined

          v-bind="attrs"
          @blur="dateInit =  parseDate(dateInitFormatted)"
          v-on="on"
        ></v-text-field>
      </template>
      <v-date-picker
        v-model="dateInit"
        :min="new Date().toISOString()"
        no-title
        @input="menuDateInit = false"
      ></v-date-picker>
    </v-menu>

    <v-menu
      ref="menuDateFinal"
      v-model="menuDateFinal"
      :close-on-content-click="false"
      transition="scale-transition"
      offset-y
      max-width="290px"
      min-width="auto"
    >
      <template v-slot:activator="{ on, attrs }">
        <v-text-field
          v-model="dateFinalFormatted"
          label="Data Final"
          outlined
          v-bind="attrs"
          @blur="dateFinal = parseDate(dateFinalFormatted)"
          v-on="on"
        ></v-text-field>
      </template>
      <v-date-picker
        v-model="dateFinal"
        :min="new Date().toISOString()"
        no-title
        @input="menuDateFinal = false"
      ></v-date-picker>
    </v-menu>
    <v-menu
      ref="menuTimeInit"
      v-model="menuTimeInit"
      :close-on-content-click="false"
      :nudge-right="40"
      :return-value.sync="timeInit"
      transition="scale-transition"
      offset-y
      max-width="290px"
      min-width="290px"
    >
      <template v-slot:activator="{ on, attrs }">
        <v-text-field
          outlined
          v-model="timeInit"
          label="Hora Inicial"
          readonly
          v-bind="attrs"
          v-on="on"
        ></v-text-field>
      </template>
      <v-time-picker
        format="24hr"
        v-if="menuTimeInit"
        v-model="timeInit"
        full-width
        @click:minute="$refs.menuTimeInit.save(timeInit)"
      ></v-time-picker>
    </v-menu>
    <v-menu
      ref="menuTimeFinal"
      v-model="menuTimeFinal"
      :close-on-content-click="false"
      :nudge-right="40"
      :return-value.sync="timeFinal"
      transition="scale-transition"
      offset-y
      max-width="290px"
      min-width="290px"
    >
      <template v-slot:activator="{ on, attrs }">
        <v-text-field
          outlined
          v-model="timeFinal"
          label="Hora Final"
          readonly
          v-bind="attrs"
          v-on="on"
        ></v-text-field>
      </template>
      <v-time-picker
        format="24hr"
        v-if="menuTimeFinal"
        v-model="timeFinal"
        full-width
        @click:minute="$refs.menuTimeFinal.save(timeFinal)"
      ></v-time-picker>
    </v-menu>
    <v-row justify="center">
      <v-col cols="auto">
        <v-btn type="submit" color="primary">Salvar</v-btn>
      </v-col>
      <v-col>
        <ButtonBack></ButtonBack>
      </v-col>
    </v-row>
  </v-form>
</template>

<script>
import ButtonBack from '@/components/ButtonBack.vue';
import { required, numeric } from 'vuelidate/lib/validators';
import { OngRepository } from '@/repository/OngRepository';
import { SocialActionRepository } from '@/repository/SocialActionRepository';

export default {
  name: 'FormSocialAction',
  components: { ButtonBack },
  props: {
    socialActionID: { type: String },
    type: { type: String, default: 'create' },
  },
  data() {
    return {
      menuTimeInit: false,
      timeInit: null,
      menuTimeFinal: false,
      timeFinal: null,
      dateInit: (
        new Date(Date.now() - (new Date()).getTimezoneOffset() * 60000)).toISOString()
        .substr(0, 10),
      dateFinal: (
        new Date(Date.now() - (new Date()).getTimezoneOffset() * 60000)).toISOString()
        .substr(0, 10),
      menuDateInit: false,
      menuDateFinal: false,
      dateInitFormatted: this.formatDate(
        (new Date(Date.now() - (new Date()).getTimezoneOffset() * 60000)).toISOString()
          .substr(0, 10),
      ),
      dateFinalFormatted: this.formatDate(
        (new Date(Date.now() - (new Date()).getTimezoneOffset() * 60000)).toISOString()
          .substr(0, 10),
      ),
      dataCharge: false,
      showToolTip: false,
      loadingAutoCompleteOngName: false,
      itemsOng: [],
      itemsCategory: [],
      loadingAutoCompleteCategoryName: false,
      searchOngName: null,
      searchCategoryName: null,
      socialAction: {
        status: 'PRIVADO',
        name: '',
        description: '',
        emailContact: '',
        vacanciesQuantity: 0,
        ong: {},
      },
    };
  },
  watch: {
    async searchOngName(value) {
      if (value === '') return;
      this.loadingAutoCompleteOngName = true;
      const data = await new OngRepository().search(value);
      this.itemsOng = [...this.itemsOng, ...data];
      this.loadingAutoCompleteOngName = false;
    },
    dateInit(val) {
      this.dateInitFormatted = this.formatDate(this.dateInit);
    },
    dateFinal(val) {
      this.dateFinalFormatted = this.formatDate(this.dateFinal);
    },
  },
  computed: {
    vacanciesQuantitiesErrors() {
      const errors = [];
      if (!this.$v.socialAction.vacanciesQuantity.$dirty) return errors;
      // eslint-disable-next-line no-unused-expressions
      !this.$v.socialAction.vacanciesQuantity.required && errors.push('Campo é Obrigatorio.');
      // eslint-disable-next-line no-unused-expressions
      !this.$v.socialAction.vacanciesQuantity.numeric && errors.push('Somente numeros são aceitos nesse campo');
      return errors;
    },
    nameErrors() {
      const errors = [];
      if (!this.$v.socialAction.name.$dirty) return errors;
      // eslint-disable-next-line no-unused-expressions
      !this.$v.socialAction.name.required && errors.push('Campo é Obrigatorio.');
      // eslint-disable-next-line no-unused-expressions
      return errors;
    },
    emailContactErrors() {
      const errors = [];
      if (!this.$v.socialAction.emailContact.$dirty) return errors;
      // eslint-disable-next-line no-unused-expressions
      !this.$v.socialAction.emailContact.required && errors.push('Campo é Obrigatorio.');
      // eslint-disable-next-line no-unused-expressions
      return errors;
    },
  },
  validations: {
    socialAction: {
      emailContact: {
        required,
      },
      name: {
        required,
      },
      vacanciesQuantity: {
        required,
        numeric,
      },
    },

  },
  methods: {
    formatDate(date) {
      if (!date) return null;

      const [year, month, day] = date.split('-');
      return `${day}/${month}/${year}`;
    },
    parseDate(date) {
      if (!date) return null;

      const [day, month, year] = date.split('/');
      return `${year}-${month.padStart(2, '0')}-${day.padStart(2, '0')}`;
    },
    async  submitForm() {
      this.$v.$touch();
      const formIsInvalid = this.$v.$error;
      if (!formIsInvalid) {
        this.$emit('requestSend');
        const data = {
          ...this.socialAction,
          dateInit: this.dateInit,
          dateFinal: this.dateFinal,
          timeInit: this.timeInit,
          timeFinal: this.timeFinal,
        };
        const repository = new SocialActionRepository();
        let responseData = {};

        if (this.type === 'create') {
          responseData = await repository.create(data);
        } else {
          responseData = await repository.update(data, this.socialActionID);
        }

        this.$emit('dataCreation', responseData);
        this.$emit('requestSend');
      }
    },
  },
  async beforeMount() {
    // const eventParam = this.$route.params.event;
    // if (eventParam !== undefined && eventParam !== null) {
    //   this.socialAction.event = { ...eventParam };
    //   this.itemsEvent = [this.activity.event];
    // }
    this.dataCharge = false;
    if (this.type === 'update') {
      const repository = new SocialActionRepository(this.socialActionID);
      const rawData = await repository.get(this.socialActionID);
      this.socialAction = {
        ...rawData,
      };
      console.log(rawData);
      // this.itemsEvent.push({ ...rawData.event });
    }
    this.dataCharge = true;
  },
};
</script>

<style scoped>

</style>
