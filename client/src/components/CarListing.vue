<script setup>
import { Car } from '@/models/Car.js';

defineProps({
  carProp: { type: Car, required: true }
})
</script>


<template>
  <b>{{ carProp.make }}</b>
</template>


<style lang="scss" scoped></style>