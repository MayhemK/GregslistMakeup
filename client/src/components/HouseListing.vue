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

    </div>
  </div>
</template>


<style lang="scss" scoped></style>