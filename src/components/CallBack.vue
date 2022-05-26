<template>
  <div id="table">
    <v-simple-table>
      <template v-slot:default>
        <thead>
          <tr>
            <th class="text-left">Nome</th>
            <th class="text-left">Pensamento C.</th>
            <th class="text-left">Conexão</th>
            <th class="text-left">Inovação</th>
            <th class="text-left">Design</th>
            <th class="text-left">Motivação</th>
            <th class="text-left">Controle</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="item in times" :key="item.value">
            <td>{{ item.text }}</td>
            <td :class="[findAward(0, item.value) ? 'blue' : '']">
              <a v-if="findAward(0, item.value)"> --------- </a>
            </td>
            <td :class="[findAward(1, item.value) ? 'blue' : '']">
              <a v-if="findAward(1, item.value)">--------- </a>
            </td>
            <td :class="[findAward(2, item.value) ? 'blue' : '']">
              <a v-if="findAward(2, item.value)"> --------- </a>
            </td>
            <td :class="[findAward(3, item.value) ? 'blue' : '']">
              <a v-if="findAward(3, item.value)"> --------- </a>
            </td>
            <td :class="[findAward(4, item.value) ? 'blue' : '']">
              <a v-if="findAward(4, item.value)"> --------- </a>
            </td>
            <td :class="[findAward(5, item.value) ? 'blue' : '']">
              <a v-if="findAward(5, item.value)"> --------- </a>
            </td>
          </tr>
        </tbody>
      </template>
    </v-simple-table>

    <v-btn :to="'/awards'" class="mx-4" fab dark small color="#00ACC1">
      <v-icon dark>mdi-arrow-left-thick</v-icon>
    </v-btn>

    <v-btn v-on:click="imprimir()" class="mx-4" fab dark small color="#00ACC1">
      <v-icon dark>mdi-printer</v-icon>
    </v-btn>
  </div>
</template>

<script>
import printJS from "print-js";

export default {
  data() {
    return {
      times: [],
      index: 0,
      dialog: false,

      items: [
        {
          name: "Pensamento Criativo",
          teams: [],
        },
        {
          name: "Conexão",
          teams: [],
        },
        {
          name: "Inovação",
          teams: [],
        },
        {
          name: "Design",
          teams: [],
        },
        {
          name: "Motivação",
          teams: [],
        },
        {
          name: "Controle",
          teams: [],
        },
      ],
    };
  },
  methods: {
    findAward(numberAward, teamNumber) {
      for (var i = 0; i < this.items[numberAward].teams.length; i++) {
        if (this.items[numberAward].teams[i].value == teamNumber) return true;
      }

      return false;
    },

    imprimir: function () {
      printJS("table", "html");
    },
  },

  created() {

    fetch("https://ftc-awards-server-mysql.herokuapp.com/teams")
      .then((response) => response.json())
      .then((json) => {
        this.times = json;
      });

    fetch(
      "https://ftc-awards-server-mysql.herokuapp.com/awards/PensamentoCriativo"
    )
      .then((response) => response.json())
      .then((json) => {
        this.items[0].teams = json;
      });

    fetch("https://ftc-awards-server-mysql.herokuapp.com/awards/Conexao")
      .then((response) => response.json())
      .then((json) => {
        this.items[1].teams = json;
      });

    fetch("https://ftc-awards-server-mysql.herokuapp.com/awards/Inovacao")
      .then((response) => response.json())
      .then((json) => {
        this.items[2].teams = json;
      });

    fetch("https://ftc-awards-server-mysql.herokuapp.com/awards/Design")
      .then((response) => response.json())
      .then((json) => {
        this.items[3].teams = json;
      });

    fetch("https://ftc-awards-server-mysql.herokuapp.com/awards/Motivacao")
      .then((response) => response.json())
      .then((json) => {
        this.items[4].teams = json;
      });

    fetch("https://ftc-awards-server-mysql.herokuapp.com/awards/Controle")
      .then((response) => response.json())
      .then((json) => {
        this.items[5].teams = json;
      });
  },
};
</script>