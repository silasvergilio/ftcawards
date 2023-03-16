<template>
  <v-container fluid>
    <v-data-iterator
      :items="items"
      :items-per-page.sync="itemsPerPage"
      hide-default-footer
    >
      <Loader v-bind:overlay="loader"> </Loader>

      <template v-slot:header>
        <v-toolbar class="mb-2" color="#1E5AA8" dark flat> </v-toolbar>
      </template>

      <!--Dialog de Confirmação -->

      <v-dialog v-model="dialog" max-width="350px">
        <v-card>
          <v-card-title class="headline">
            {{ items[awardIndex].name }}
          </v-card-title>

          <v-img
            
            v-on:error="imgError(awardIndex, index)"
            :src="
              require('../assets/fotos_times/' +
                items[awardIndex].teams[index].value +
                '.jpg')
            "
          />

          <v-card-text v-if="items[0].teams[0]">
            {{ items[awardIndex].teams[index].motive }}
          </v-card-text>
          <v-card-actions
            v-if="this.$store.state.user.permission == 'Administrador'"
            style="display: flex; flex-direction: column"
          >
            <v-spacer></v-spacer>

            <v-btn
              color="#F9A825"
              text
              @click="
                dialog = false;
                award(false);
              "
            >
              Não Premiar
            </v-btn>

            <v-btn
              color="#F9A825"
              text
              @click="
                dialog = false;
                award(true);
              "
            >
              Premiar
            </v-btn>
            <br />
            <v-btn
              v-if="this.$store.state.user.permission == 'Administrador'"
              color="#F9A825"
              text
              @click="
                dialog = false;
                deleteAward();
              "
            >
              Deletar
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>
      <!--Dialog de Confirmação -->

      <template>
        <v-row>
          <v-col
            v-for="(item, index) in items"
            :key="item.name"
            cols="12"
            sm="6"
            md="4"
            lg="3"
            style="max-width: 100%"
          >
            <v-card>
              <v-card-title class="subheading">{{ item.name }}</v-card-title>

              <v-list>
                <draggable
                  v-model="item.teams"
                  :group="item"
                  style="min-height: 10px"
                >
                  <v-list-item
                    color="primary"
                    v-for="(team, teamIndex) in item.teams"
                    v-bind:key="team.id"
                    v-on:click="
                      dialog = true;
                      changeIndex(team.value, item.name);
                    "
                    :class="[
                      team.premiado
                        ? positionClass(index, teamIndex)
                        : alreadyAwarded(team.value, index)
                        ? 'alreadyAwarded'
                        : 'tile',
                    ]"
                  >
                    <v-list-item-content>
                      <v-list-item-title>
                        <v-icon
                          v-if="
                            item.teams.findIndex((x) => x.text === team.text) +
                              1 ==
                            1
                          "
                          >mdi-trophy</v-icon
                        >
                        <v-icon
                          v-else-if="
                            item.teams.findIndex((x) => x.text === team.text) +
                              1 >
                            1
                          "
                          >mdi-numeric-{{
                            item.teams.findIndex((x) => x.text === team.text) +
                            1
                          }}-box</v-icon
                        >

                        <b> {{ team.value }} - {{ team.text }} </b>

                        <v-icon>
                          mdi-alpha-{{
                            team.sala.toLowerCase()
                          }}-circle-outline</v-icon
                        >
                      </v-list-item-title>
                    </v-list-item-content>
                  </v-list-item>
                </draggable>
              </v-list>
            </v-card>
          </v-col>
        </v-row>
      </template>

      <v-btn
        v-on:click="updateAndSave()"
        class="mx-4"
        fab
        dark
        large
        color="blue darken-2"
      >
        <v-icon dark>mdi-content-save-all</v-icon>
      </v-btn>

      <v-btn
        :to="'/callback'"
        class="mx-4"
        fab
        dark
        large
        color="teal darken-3"
      >
        <v-icon dark>mdi-google-spreadsheet</v-icon>
      </v-btn>

      <template v-slot:footer>
        <v-toolbar class="mt-2" color="#1E5AA8" dark flat> </v-toolbar>
      </template>
    </v-data-iterator>
  </v-container>
</template>

<script>
import draggable from "vuedraggable";
import Loader from "./Loader.vue";

export default {
  components: {
    draggable,
    Loader,
  },

  data: () => ({
    awardReqCount: 0,
    awardCount: 0,
    orderReqCount: 0,
    itemsPerPage: 5,
    loader: false,

    dialog: false,

    index: 0,
    awardIndex: 0,

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
      {
        name: "Inspiração",
        teams: [],
      },
    ],
  }),
  methods: {
    say: function (msg) {
      alert(msg);
    },

    imgError(awardIndex, index) {
      alert("error loading image");
      this.items[awardIndex].teams[index].imageLoad = false;
    },

    deleteAward() {
      this.loader = true;
      let requisicao = {
        id: this.items[this.awardIndex].teams[this.index].Teams_idTime,
      };

      var uri = "";
      switch (this.items[this.awardIndex].name) {
        case "Pensamento Criativo":
          uri =
            "https://ftc-awards-server-mysql.herokuapp.com/awards/pensamentocriativo";
          break;
        case "Conexão":
          uri = "https://ftc-awards-server-mysql.herokuapp.com/awards/conexao";
          break;
        case "Inovação":
          uri = "https://ftc-awards-server-mysql.herokuapp.com/awards/inovacao";
          break;
        case "Motivação":
          uri =
            "https://ftc-awards-server-mysql.herokuapp.com/awards/motivacao";
          break;
        case "Design":
          uri = "https://ftc-awards-server-mysql.herokuapp.com/awards/design";
          break;
        case "Controle":
          uri = "https://ftc-awards-server-mysql.herokuapp.com/awards/controle";
          break;
        case "Inspiração":
          uri = "https://ftc-awards-server-mysql.herokuapp.com/awards/inspire";
          break;
        default:
          break;
      }

      fetch(uri, {
        method: "DELETE",
        body: JSON.stringify(requisicao),
        headers: {
          "Content-Type": "application/json",
        },
      }).then(() => {
        this.loader = false;
        location.reload();
      });
    },

    alreadyAwarded(teamValue, awardIndex) {
      for (var i = 0; i < this.items.length; i++) {
        if (i == awardIndex) continue;
        for (var k = 0; k < this.items[i].teams.length; k++) {
          if (
            this.items[i].teams[k].value == teamValue &&
            this.items[i].teams[k].premiado
          )
            return true;
        }
      }
      return false;
    },

    positionClass: function (award, index) {
      for (var k = 0; k < index; k++) {
        if (this.items[award].teams[k].premiado) return "secondPlace";
      }

      return "winner";
    },

    updateAndSave: function () {
      this.loader = true;
      for (let i = 0; i < this.items.length; i++) {
        for (let k = 0; k < this.items[i].teams.length; k++) {
          this.awardCount++;
          this.position(i, k);
        }
      }
    },

    changeIndex: function (newTeam, newAward) {
      for (let i = 0; i < this.items.length; i++) {
        if (newAward == this.items[i].name) this.awardIndex = i;
      }

      for (let k = 0; k < this.items[this.awardIndex].teams.length; k++) {
        if (newTeam == this.items[this.awardIndex].teams[k].value)
          this.index = k;
      }
    },

    position: function (awardIndex, teamIndex) {
      var requisicao = {
        position: teamIndex,
        id: this.items[awardIndex].teams[teamIndex].Teams_idTime,
      };
      var uri = "";

      switch (this.items[awardIndex].name) {
        case "Pensamento Criativo":
          uri =
            "https://ftc-awards-server-mysql.herokuapp.com/order/pensamentocriativo";
          break;
        case "Conexão":
          uri = "https://ftc-awards-server-mysql.herokuapp.com/order/conexao";
          break;
        case "Inovação":
          uri = "https://ftc-awards-server-mysql.herokuapp.com/order/inovacao";
          break;
        case "Motivação":
          uri = "https://ftc-awards-server-mysql.herokuapp.com/order/motivacao";
          break;
        case "Design":
          uri = "https://ftc-awards-server-mysql.herokuapp.com/order/design";
          break;
        case "Controle":
          uri = "https://ftc-awards-server-mysql.herokuapp.com/order/controle";
          break;
        case "Inspiração":
          uri = "https://ftc-awards-server-mysql.herokuapp.com/order/inspire";
          break;
        default:
          break;
      }

      fetch(uri, {
        method: "PUT",
        body: JSON.stringify(requisicao),
        headers: {
          "Content-Type": "application/json",
        },
      }).then(() => {
        this.orderReqCount++;
        if (this.orderReqCount == this.awardCount) this.loader = false;
      });
    },

    award: function (intention) {
      let allowAward = true;
      this.loader = true;

      if (intention) {
        for (let j = 0; j < this.items[this.awardIndex].teams.length; j++) {
          if (this.items[this.awardIndex].teams[j].premiado) allowAward = true;
        }
      }

      if (allowAward || this.items[this.awardIndex].name == "Inspiração") {
        var requisicao = {
          value: this.items[this.awardIndex].teams[this.index].value,
          awardStatus: intention,
          id: this.items[this.awardIndex].teams[this.index].Teams_idTime,
        };
        /* eslint-disable*/
        var uri = "";

        switch (this.items[this.awardIndex].name) {
          case "Pensamento Criativo":
            uri =
              "https://ftc-awards-server-mysql.herokuapp.com/awards/pensamentocriativo";
            break;
          case "Conexão":
            uri =
              "https://ftc-awards-server-mysql.herokuapp.com/awards/conexao";
            break;
          case "Inovação":
            uri =
              "https://ftc-awards-server-mysql.herokuapp.com/awards/inovacao";
            break;
          case "Motivação":
            uri =
              "https://ftc-awards-server-mysql.herokuapp.com/awards/motivacao";
            break;
          case "Design":
            uri = "https://ftc-awards-server-mysql.herokuapp.com/awards/design";
            break;
          case "Controle":
            uri =
              "https://ftc-awards-server-mysql.herokuapp.com/awards/controle";
            break;
          case "Inspiração":
            uri =
              "https://ftc-awards-server-mysql.herokuapp.com/awards/inspire";
            break;
          default:
            break;
        }
      }

      fetch(uri, {
        method: "PUT",
        body: JSON.stringify(requisicao),
        headers: {
          "Content-Type": "application/json",
        },
      }).then((response) => {
        this.loader = false;
        this.items[this.awardIndex].teams[this.index].premiado = intention;
      });
      //  location.reload();
    },
  },
  created() {
    this.loader = true;
    fetch(
      "https://ftc-awards-server-mysql.herokuapp.com/awards/pensamentocriativo"
    )
      .then((response) => response.json())
      .then((json) => {
        /* eslint-disable*/
        this.awardReqCount++;
        if (this.awardReqCount == 6) this.loader = false;
        this.items[0].teams = json;
        this.items[0].teams.sort(function (a, b) {
          return a.position - b.position;
        });
        this.items[0].teams.forEach((element) => {
          element.imageLoad = true;
        });
      });

    fetch("https://ftc-awards-server-mysql.herokuapp.com/awards/conexao")
      .then((response) => response.json())
      .then((json) => {
        this.awardReqCount++;
        if (this.awardReqCount == 6) this.loader = false;

        this.items[1].teams = json;
        this.items[1].teams.sort(function (a, b) {
          return a.position - b.position;
        });
        this.items[1].teams.forEach((element) => {
          element.imageLoad = true;
        });
      });

    fetch("https://ftc-awards-server-mysql.herokuapp.com/awards/inovacao")
      .then((response) => response.json())
      .then((json) => {
        this.awardReqCount++;
        if (this.awardReqCount == 6) this.loader = false;

        this.items[2].teams = json;

        this.items[2].teams.sort(function (a, b) {
          return a.position - b.position;
        });
        this.items[2].teams.forEach((element) => {
          element.imageLoad = true;
        });
      });

    fetch("https://ftc-awards-server-mysql.herokuapp.com/awards/design")
      .then((response) => response.json())
      .then((json) => {
        this.awardReqCount++;
        if (this.awardReqCount == 6) this.loader = false;

        this.items[3].teams = json;
        this.items[3].teams.sort(function (a, b) {
          return a.position - b.position;
        });
        this.items[3].teams.forEach((element) => {
          element.imageLoad = true;
        });
      });

    fetch("https://ftc-awards-server-mysql.herokuapp.com/awards/motivacao")
      .then((response) => response.json())
      .then((json) => {
        this.awardReqCount++;
        if (this.awardReqCount == 6) this.loader = false;

        this.items[4].teams = json;
        this.items[4].teams.sort(function (a, b) {
          return a.position - b.position;
        });
        this.items[4].teams.forEach((element) => {
          element.imageLoad = true;
        });
      });

    fetch("https://ftc-awards-server-mysql.herokuapp.com/awards/controle")
      .then((response) => response.json())
      .then((json) => {
        this.awardReqCount++;
        if (this.awardReqCount == 6) this.loader = false;

        this.items[5].teams = json;
        this.items[5].teams.sort(function (a, b) {
          return a.position - b.position;
        });
        this.items[5].teams.forEach((element) => {
          element.imageLoad = true;
        });
      });
    fetch("https://ftc-awards-server-mysql.herokuapp.com/awards/inspire")
      .then((response) => response.json())
      .then((json) => {
        this.awardReqCount++;
        if (this.awardReqCount == 7) this.loader = false;

        this.items[6].teams = json;
        this.items[6].teams.sort(function (a, b) {
          return a.position - b.position;
        });
        this.items[6].teams.forEach((element) => {
          element.imageLoad = true;
        });
      });
  },
};
</script>

<style scoped>
.tile:hover {
  background: #c8e9f5;
}

.winner {
  background: #ffd740;
}

.secondPlace {
  background: #448aff;
}

.alreadyAwarded {
  background: #ef9a9a;
}
</style>