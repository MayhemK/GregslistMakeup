<script setup>
import { AppState } from '@/AppState.js';
import { Car } from '@/models/Car.js';
import { computed } from 'vue';

const cars = computed(() => AppState.cars)

defineProps({
  carProp: { type: Car, required: true }
})
</script>


<template>
  <div class="row">
    <div class="col-md-4">
      <img :src="carProp.imgUrl" :alt="`A picture of this ${carProp.year} ${carProp.make} ${carProp.model}`"
        class="w-100">
    </div>
    <div class="col-md-8">
      <div>
        {{ carProp.color }}
      </div>
    </div>
  </div>
</template>


<style lang="scss" scoped></style>