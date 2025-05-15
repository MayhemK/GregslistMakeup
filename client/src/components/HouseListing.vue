<script setup>
import { House } from '@/models/House.js';

defineProps({
  house: { type: House, required: true }
})
</script>


<template>
  <b>{{ house.bedrooms }}</b>
</template>


<style lang="scss" scoped></style>