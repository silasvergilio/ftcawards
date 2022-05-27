<template>
  <div>
    <v-dialog v-model="dialog" max-width="290">
      <v-card>
        <!--    <v-img
          :src="require('../assets/fotos_times/' + times[index].value + '.jpg')"
        /> -->
      </v-card>
    </v-dialog>
    <!--Dialog de Confirmação -->

      <Loader v-bind:overlay="loader"> </Loader>

    <v-simple-table>
      <template v-slot:default>
        <thead>
          <tr>
            <th class="text-left">Nome</th>
            <th class="text-left">Número</th>
            <th class="text-left">Estado</th>
            <th class="text-left">Escola</th>
          </tr>
        </thead>
        <tbody>
          <tr
            v-for="item in times"
            :key="item.value"
            v-on:click="
              dialog = true;
              changeIndex(item.value);
            "
          >
            <td>{{ item.text }}</td>
            <td>{{ item.value }}</td>
            <td>{{ item.state }}</td>
            <td>{{ item.school }}</td>
          </tr>
        </tbody>
      </template>
    </v-simple-table>
  </div>
</template>

<script>
import Loader from "./Loader.vue";

export default {
  data() {
    return {
      times: [],
      index: 0,
      dialog: false,
      loader: false,
    };
  },
  components:{
    Loader
  },
  methods: {
    changeIndex: function (newTeam) {
      this.$store.commit("increment");

      for (let k = 0; k < this.times.length; k++) {
        if (newTeam == this.times[k].value) this.index = k;
      }
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
      })
      .catch(() => {});
  },
};
</script>