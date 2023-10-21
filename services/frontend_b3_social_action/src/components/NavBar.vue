<template>
  <div>
    <v-app-bar  color="grey lighten-3" class="hidden-sm-and-down" app  >
      <v-btn icon @click.native="navigationToPage('dashboard',0)">
        <v-icon>mdi-home</v-icon>
      </v-btn>
      <v-toolbar-title>
        Gestão de Ações Sociais
      </v-toolbar-title>
      <v-spacer></v-spacer>
      <v-toolbar-items >
        <v-btn
          v-for="(item,index) in filteredItems()" :key="item.text"
          small
          text
          :plain="selectedNavBarItem(index)"
          @click="navigationToPage(item.toPageName, index)"
        >
          {{item.text}}
        </v-btn>
        <v-btn small @click="logout" text  v-if="keycloak.authenticated">
          Sair
        </v-btn>
      </v-toolbar-items>
    </v-app-bar>
    <v-app-bar app color="grey lighten-3" class="hidden-md-and-up">
      <v-toolbar-title>Gestão de Ações Sociais</v-toolbar-title>
      <v-spacer></v-spacer>
      <v-btn icon  @click.native="dialog = true">
        <v-icon>
          mdi-menu
        </v-icon>
      </v-btn>
      <v-dialog v-model="dialog" fullscreen hide-overlay transition="dialog-bottom-transition">
        <v-card >
          <v-toolbar flat color="grey lighten-3">
            <v-toolbar-title>Gestão de Ações Sociais</v-toolbar-title>

            <v-spacer></v-spacer>

            <v-btn icon @click.native="dialog = false">
              <v-icon>mdi-close</v-icon>
            </v-btn>
          </v-toolbar>

          <v-list>
            <v-list-item-group v-model="selectedItem">
              <v-list-item
                link
                v-for="(item, index) in items"
                :key="index"
                @click="navigationToPage(item.toPageName, index)"
              >
                <v-list-item-content>
                  <v-list-item-title >{{ item.text }}</v-list-item-title>
                </v-list-item-content>
              </v-list-item>
              <v-list-item
                @click="logout"
              >
                <v-list-item-content>
                  <v-list-item-title>
                    Sair aqyy
                  </v-list-item-title>
                </v-list-item-content>
              </v-list-item>
            </v-list-item-group>
          </v-list>
        </v-card>
      </v-dialog>

    </v-app-bar>
  </div>
</template>

<script>

import Keycloak from '@/plugins/keycloak';

export default {
  name: 'NavBar',
  data() {
    return {
      selectedItem: -1,
      dialog: false,
      items: [],
      keycloak: {},
    };
  },
  methods: {
    filteredItems() {
      return this.items.filter((e) => this.keycloak.hasRealmRole(e.permission) || e.permission === 'non-permission-needed');
    },
    selectedNavBarItem(index) {
      if (this.selectedItem === index) {
        return true;
      }
      return false;
    },
    async navigationToPage(pageName, listIndex) {
      this.selectedItem = listIndex;
      await this.$router.push({ name: pageName });
    },
    async logout() {
      await this.keycloak.logout({ redirectUri: 'http://localhost:3000' });
    },
  },
  updated() {
    this.keycloak = Keycloak();
  },
  mounted() {
    this.items = this.$store.state.navbar.items;
    this.keycloak = Keycloak();
  },
};
</script>

<style scoped>

</style>
