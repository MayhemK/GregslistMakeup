<script setup>
import { AppState } from '@/AppState.js';
import HouseForm from '@/components/HouseForm.vue';
import HouseListing from '@/components/HouseListing.vue';
import { housesService } from '@/services/HousesService.js';
import { Pop } from '@/utils/Pop.js';
import { computed, onMounted } from 'vue';

const houses = computed(() => AppState.houses)
const account = computed(() => AppState.account)

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
        <div class="text-center fs-2 fw-bold">
          Houses
        </div>
        <hr>
      </div>
    </div>
  </section>
  <section v-if="account" class="container">
    <div class="row">
      <div class="col-md-8">
        <HouseForm />
      </div>
      <div class="col-md-4">
        <img
          src="https://realestatesupplystore.com/cdn/shop/products/S110RedHomeForSaleHouseLeft1000@2x.jpg?v=1602701017"
          alt="" class="w-100">
      </div>
    </div>
  </section>
  <section v-else>
    <h2 class="text-center mb-5">Please Login to Post!</h2>
  </section>
  <section class="container">
    <div class="row">
      <div v-for="house in houses" :key="house.id" class="col-12">
        <HouseListing :houseProp="house" />
      </div>
    </div>
  </section>
</template>


<style lang="scss" scoped></style>