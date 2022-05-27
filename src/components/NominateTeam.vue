<template>
  <v-form ref="form">
    <v-container fluid>
      <CardTitlePage
        titulo="Nomear time a um prêmio"
        icon="mdi-file-tree"
        body="Indicar um time a um prêmio. Lembre-se de seguir as instruções do Juiz-Chefe quanto 
      a quantidade, critérios e metodologia"
      >
      </CardTitlePage>

      <Loader v-bind:overlay="loader"> </Loader>

      <v-row>
        <v-col cols="12" md="4">
          <v-combobox
            v-model="team"
            :items="times"
            label="Selecione o time"
          ></v-combobox>
        </v-col>

        <v-col cols="12" md="4">
          <v-combobox
            v-model="award"
            :items="premios"
            label="Selecione o prêmio"
          ></v-combobox>
        </v-col>

        <v-col cols="12" md="4">
          <v-combobox
            v-model="room"
            :items="salas"
            label="Selecione a sala"
          ></v-combobox>
        </v-col>
      </v-row>

      <v-row>
        <v-col cols="12" md="12">
          <v-container fluid>
            <v-textarea v-model="message" label="Justificativa"></v-textarea>
          </v-container>
        </v-col>
      </v-row>

      <v-row>
        <v-col cols="12" md="4">
          <v-btn
            @click="indicaTime()"
            color="#1E5AA8"
            depressed
            elevation="5"
            outlined
            :disabled="!invalid"
          >
            Enviar
          </v-btn>
        </v-col>
      </v-row>
    </v-container>
  </v-form>
</template>

<script>
import CardTitlePage from "./CardTitlePage";
import Loader from "./Loader.vue";

export default {
  methods:{
     AwardException(message, serverError) {
      this.message = message;
      this.name = "AwardException";
      this.sqlError = serverError;
    },
  },
  data() {
    return {
      times: [],
      timesNome: [],
      loader: false,

      premios: [
        { text: "Pensamento Criativo", value: 1 },
        { text: "Conexão", value: 2 },
        { text: "Inovação", value: 3 },
        { text: "Design", value: 4 },
        { text: "Motivação", value: 5 },
        { text: "Controle", value: 6 },
      ],
      salas: [{ text: "A" }, { text: "B" }, { text: "C" }, { text: "D" }],

      message: "",
      team: "",
      award: "",
      room: "",
      check() {
        if (!this.team || !this.award) alert("Complete a indicação");
      },
      indicaTime: function () {
        this.loader = true;
        var requisicao = {
          text: this.team.text,
          motive: this.message,
          premiado: false,
          sala: this.room.text,
          position: 0,
        };
        // window.alert(JSON.stringify(requisicao));
        var url;

        switch (this.award.value) {
          case 1:
            url =
              "https://ftc-awards-server-mysql.herokuapp.com/awards/pensamentocriativo";
            break;
          case 2:
            url =
              "https://ftc-awards-server-mysql.herokuapp.com/awards/conexao";
            break;
          case 3:
            url =
              "https://ftc-awards-server-mysql.herokuapp.com/awards/inovacao";
            break;
          case 4:
            url = "https://ftc-awards-server-mysql.herokuapp.com/awards/design";
            break;
          case 5:
            url =
              "https://ftc-awards-server-mysql.herokuapp.com/awards/motivacao";
            break;
          case 6:
            url =
              "https://ftc-awards-server-mysql.herokuapp.com/awards/controle";
            break;
        }
        fetch(url, {
          credentials: "include",
          method: "post",
          body: JSON.stringify(requisicao),
          headers: {
            "Content-Type": "application/json",
          },
        }).then((response) => {
          /* eslint-disable*/
          return response.json();
        })
        .then((response) => {
          /* eslint-disable*/
          if (response.SqlError) {
            if (response.SqlError.errno == 1010) {
              throw new this.AwardException(
                "Equipe Já indicada",
                response.SqlError
              );
            } 
          }
        })
        .catch((err) => {
          /* eslint-disable*/
          this.dialog = true;
          this.dialogMessage.title = "Erro";
          this.dialogMessage.message = err.message;
        });

        this.$refs.form.reset();
      },
    };
  },
  components: {
    CardTitlePage,
    Loader,
  },
  computed: {
    invalid() {
      if (this.message) return this.message.length > 60;
      return false;
    },
  },
  created() {
    this.loader = true;
    fetch("https://ftc-awards-server-mysql.herokuapp.com/teams", {
      credentials: "include",
    })
      .then((response) => response.json())
      .then((json) => {
        this.loader = false;
        this.times = json;
      });
  },
};
</script>