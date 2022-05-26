<template>
  <v-form ref="form">
    <v-container>
      <CardTitlePage
        titulo="Adicionar Time"
        icon="mdi-shield-plus-outline"
        body="Adicione um time ao sistema, não se esqueça de confirmar os dados antes de enviar. Esta ação deve ser realizada apenas
      pela equipe de organização do evento"
      >
      </CardTitlePage>

      <v-row>
        <v-container class="container-inputs">
          <v-col cols="12" md="4">
            <v-text-field
              prepend-icon="mdi-card-text-outline"
              label="Nome da Equipe"
              v-model="teamName"
            ></v-text-field>
          </v-col>

          <v-col cols="12" md="4">
            <v-text-field
              label="Número da Equipe"
              prepend-icon="mdi-pound-box-outline"
              v-model="teamNumber"
              :rules="[rules.teamNumber]"
              v-mask="'###############'"
            ></v-text-field>
          </v-col>

          <v-col cols="12" md="4">
            <v-text-field
              label="Número da Equipe"
              prepend-icon="mdi-pound-box-outline"
              v-model="teamNumber"
              :rules="[rules.teamNumber]"
              v-mask="'###############'"
            ></v-text-field>
          </v-col>

          <v-col cols="12" md="4">
            <v-text-field
              label="Número da Equipe"
              prepend-icon="mdi-pound-box-outline"
              v-model="teamNumber"
              :rules="[rules.teamNumber]"
              v-mask="'###############'"
            ></v-text-field>
          </v-col>

          <v-col cols="12" md="4">
            <v-btn
              class="
                white--text
                v-btn v-btn--depressed v-btn--flat v-btn--outlined
                theme--light
                v-size--default
                blue--text
                text--accent-4
              "
              :rounded="true"
              :outlined="true"
              v-on:click="
                adicionaTime(teamName, teamNumber, 'EscolaTime', 'EstadoTime')
              "
            >
              Adicionar
            </v-btn>
          </v-col>
        </v-container>
      </v-row>
    </v-container>
  </v-form>
</template>

<style scoped>
.container-inputs {
  display: flex;
  flex-direction: column;
  align-items: center;
}
</style>

<script>
import CardTitlePage from "./CardTitlePage";

export default {
  data() {
    return {
      teamNumber: "",
      teamName: "",
      rules: {
        teamNumber: (value) => {
          const pattern = /^(0|[1-9][0-9]*)$/;
          return pattern.test(value) || "Número não válido.";
        },
      },
    };
  },
  components: {
    CardTitlePage,
  },

  methods: {
    adicionaTime: function (nomeTime, numeroTime, escolaTime, estadoTime) {
      var requisicao = {
        text: nomeTime,
        value: numeroTime,
        school: escolaTime,
        state: estadoTime,
      };
      window.alert(JSON.stringify(requisicao));
      this.$refs.form.reset();

      fetch("http://localhost:3000/teams", {
        method: "post",
        body: JSON.stringify(requisicao),
        headers: {
          "Content-Type": "application/json",
        },
      }).then(function () {});
    },
  },
};
</script>


