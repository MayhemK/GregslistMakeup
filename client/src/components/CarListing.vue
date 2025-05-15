<script setup>
import { Car } from '@/models/Car.js';

defineProps({
  car: { type: Car, required: true }
})
</script>


<template>
  <div v-if="car">
    <div class="row">
      <div class="col-md-4">
        <img :src="car.imgUrl" :alt="`A picture of this ${car.year} ${car.make} ${car.model}`" class="w-100">
      </div>
      <div class="col-md-8">
        <div>

        </div>
      </div>
    </div>
  </div>
  <div v-else>Page Loading ERROR</div>
</template>


<style lang="scss" scoped></style>