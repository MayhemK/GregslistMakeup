<script setup>
import { AppState } from '@/AppState.js';
import CarListing from '@/components/CarListing.vue';
import { carsService } from '@/services/CarsService.js';
import { Pop } from '@/utils/Pop.js';
import { computed, onMounted } from 'vue';

const cars = computed(() => AppState.cars)

onMounted(() => {
  getCars()
})

async function getCars() {
  try {
    await carsService.getCars()
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
          Cars
        </div>
        <hr>
      </div>
    </div>
  </section>
  <section class="container">
    <div class="row">
      <div v-for="car in cars" :key="car.id" class="col-12">
        <CarListing />
      </div>
    </div>
  </section>
</template>


<style lang="scss" scoped></style>