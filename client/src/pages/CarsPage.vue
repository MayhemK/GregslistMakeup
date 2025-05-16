<script setup>
import { AppState } from '@/AppState.js';
import CarForm from '@/components/CarForm.vue';
import CarListing from '@/components/CarListing.vue';
import { carsService } from '@/services/CarsService.js';
import { Pop } from '@/utils/Pop.js';
import { computed, onMounted } from 'vue';

const cars = computed(() => AppState.cars)
const account = computed(() => AppState.account)

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
        <div class="text-center fs-2 fw-bold">
          Cars
        </div>
        <hr>
      </div>
    </div>
  </section>
  <section v-if="account" class="container">
    <div class="row">
      <div class="col-md-8">
        <CarForm />
      </div>
      <div class="col-md-4">
        <img src="https://i.etsystatic.com/17211177/r/il/ba78ca/1554305857/il_794xN.1554305857_426y.jpg" alt=""
          class="w-100">
      </div>
    </div>
  </section>
  <section v-else>
    <h2 class="text-center mb-5">Please Login to Post!</h2>
  </section>
  <section class="container">
    <div class="row">
      <div v-for="car in cars" :key="car.id" class="col-12">
        <CarListing :carProp="car" />
      </div>
    </div>
  </section>
</template>


<style lang="scss" scoped></style>