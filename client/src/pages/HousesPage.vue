<script setup>
import { housesService } from '@/services/HousesService.js';
import { Pop } from '@/utils/Pop.js';
import { onMounted } from 'vue';

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
  Houses page
</template>


<style lang="scss" scoped></style>