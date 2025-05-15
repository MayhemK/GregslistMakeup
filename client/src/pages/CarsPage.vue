<script setup>
import { carsService } from '@/services/CarsService.js';
import { Pop } from '@/utils/Pop.js';
import { onMounted } from 'vue';

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
  <b>cars page</b>
</template>


<style lang="scss" scoped></style>