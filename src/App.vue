<template>
  <v-app id="inspire">
    <v-navigation-drawer v-model="drawer" app>
      <v-list dense>
        <v-list-item
          v-for="menuItem in this.allowedMenuItems"
          v-bind:key="menuItem.id"
          :to="menuItem.route"
        >
          <v-list-item-action>
            <v-icon>{{ menuItem.icon }}</v-icon>
          </v-list-item-action>
          <v-list-item-content>
            <v-list-item-title>{{ menuItem.name }}</v-list-item-title>
          </v-list-item-content>
        </v-list-item>

        <v-img :src="require('./assets/logo.png')" />
      </v-list>
    </v-navigation-drawer>

    <v-app-bar app color="#A5CA18" dark>
      <v-app-bar-nav-icon @click.stop="drawer = !drawer" />
      <v-toolbar-title>FTC - Freight Frenzy - Etapa Nacional</v-toolbar-title>
      <v-toolbar-title v-if="this.$store.state.user" class="user-title">
        {{ this.$store.state.user.fullName }}
      </v-toolbar-title>


      <v-btn
      v-if="this.$store.state.user"
        :disabled="invalid"
        color="#1E5AA8"
        depressed
        elevation="5"
        outlined
      >
        Logout
      </v-btn>
    </v-app-bar>

    <v-content>
      <router-view></router-view>
    </v-content>
    <v-footer color="#68C3E2" app>
      <span class="white--text">&copy; 2022 Silas dos Santos Vergilio</span>
    </v-footer>
  </v-app>
</template>

<style  scoped>
.user-title {
  margin-left: 50rem;
}
</style>
<script>
export default {
  props: {
    source: String,
  },
  data: () => ({
    user: null,
    drawer: null,
    menuItens: [
      {
        name: "Login",
        icon: "mdi-login",
        route: "/login",
        permission: [""],
      },
      {
        name: "Adicionar Usuário",
        icon: "mdi-account-multiple-plus",
        route: "/adduser",
        permission: [""],
      },
      {
        name: "Adicionar Time",
        icon: "mdi-shield-plus-outline",
        route: "/addTeam",
        permission: ["Administrador"],
      },

      {
        name: "Lista de Times",
        icon: "mdi-account-badge-horizontal-outline",
        route: "/listTeams",
        permission: ["Administrador", "Juiz de Sala"],
      },

      {
        name: "Indicar Times",
        icon: "mdi-file-tree",
        route: "/nominateTeam",
        permission: ["Administrador", "Juiz de Sala"],
      },
      {
        name: "Indicações",
        icon: "mdi-trophy-award",
        route: "/awards",
        permission: ["Administrador", "Juiz de Sala"],
      },
    ],
  }),

  components: {},
  computed: {
    allowedMenuItems() {
      var allowedMenuItems = [];
      if (!this.$store.state.user) {
        if (this.menuItens.indexOf(this.menuItens[0] === -1))
          allowedMenuItems.push(this.menuItens[0]);
        allowedMenuItems.push(this.menuItens[1]);
      }
      this.menuItens.forEach((menuItem) => {
        if (this.$store.state.user) {
          if (menuItem.permission.includes(this.$store.state.user.permission)) {
            allowedMenuItems.push(menuItem);
          }
        }
      });
      return allowedMenuItems;
    },
  },
};
</script>