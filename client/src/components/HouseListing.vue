<script setup>
import { House } from '@/models/House.js';

defineProps({
  houseProp: { type: House, required: true }
})
</script>


<template>
  <div class="row">
    <div class="col-md-4">
      <img :src="houseProp.imgUrl" :alt="`A picture of this ${houseProp.year} ${houseProp.bedrooms} bedroom house`"
        class="w-100">
    </div>
    <div class="col-md-8">
      <div>
        <p class="fs-3 fw-bold"><span>$</span>{{ houseProp.price }}</p>
        <p class="fs-4">{{ houseProp.bedrooms }} bedroom(s) </p>
        <p class="fs-4">{{ houseProp.bathrooms }} bathroom(s) </p>
        <p class="fs-4">{{ houseProp.levels }} level(s) </p>
      </div>
    </div>
  </div>
</template>


<style lang="scss" scoped></style>