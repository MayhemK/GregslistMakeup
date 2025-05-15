<script setup>
import { AppState } from '@/AppState.js';
import HouseLIsting from '@/components/HouseLIsting.vue';
import { housesService } from '@/services/HousesService.js';
import { Pop } from '@/utils/Pop.js';
import { computed, onMounted } from 'vue';

const houses = computed(() => AppState.houses)

onMounted(() => {
  getHouses()
})

async function getHouses() {
  try {
    await housesService.getHouses()
  }
  catch (error) {
    Pop.error(error);
  }
}
</script>


<template>
  <section class="container">
    <div class="row">
      <div class="col-12 mt-3">
        <div class="text-center">
          Houses
        </div>
        <hr>
      </div>
    </div>
  </section>
  <section class="container">
    <div class="row">
      <div v-for="house in houses" :key="house.id" class="col-12">
        <HouseLIsting :houseProp="house" />
      </div>
    </div>
  </section>
</template>


<style lang="scss" scoped></style>