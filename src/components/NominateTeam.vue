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

export default {
  data() {
    return {
      times: [],
      timesNome: [],

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
        var requisicao = {
          text: this.team.text,
          motive: this.message,
          premiado: false,
          sala: this.room.text,
          position: 0,
        };
        // window.alert(JSON.stringify(requisicao));
        var url;
        var BASE_URI = location.hostname;

        switch (this.award.value) {
          case 1:
            url = "http://" + BASE_URI + ":3000/awards/pensamentocriativo";
            break;
          case 2:
            url = "http://" + BASE_URI + ":3000/awards/conexao";
            break;
          case 3:
            url = "http://" + BASE_URI + ":3000/awards/inovacao";
            break;
          case 4:
            url = "http://" + BASE_URI + ":3000/awards/design";
            break;
          case 5:
            url = "http://" + BASE_URI + ":3000/awards/motivacao";
            break;
          case 6:
            url = "http://" + BASE_URI + ":3000/awards/controle";
            break;
        }
        fetch(url, {
          credentials: "include",
          method: "post",
          body: JSON.stringify(requisicao),
          headers: {
            "Content-Type": "application/json",
          },
        }).then(function () {
          //window.alert("Time adicionado com sucesso !");
          //window.alert(response.status);
        });

        this.$refs.form.reset();
      },
    };
  },
  components: {
    CardTitlePage,
  },
  computed: {
    invalid() {
      if(this.message) return this.message.length > 60;
      return false;

    },
  },
  created() {
    var BASE_URI = location.hostname;

    fetch("http://" + BASE_URI + ":3000/teams", {
      credentials: "include",
    })
      .then((response) => response.json())
      .then((json) => {
        this.times = json;
        // console.log(this.times);
      });
  },
};
</script>