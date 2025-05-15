<script setup>
import { House } from '@/models/House.js';

defineProps({
  houseProp: { type: House, required: true }
})
</script>


<template>
  <b>{{ houseProp.bedrooms }}</b>
</template>


<style lang="scss" scoped></style>