<script setup>
import { AppState } from '@/AppState.js';
import { Car } from '@/models/Car.js';
import { carsService } from '@/services/CarsService.js';
import { Pop } from '@/utils/Pop.js';
import { computed } from 'vue';

const account = computed(() => AppState.account)

defineProps({
  carProp: { type: Car, required: true }
})

async function deleteCar(carId) {
  try {
    const confirmed = await Pop.confirm('Are you sure you want to delete this car?', 'Action is permanent', 'Yes', 'No')
    if (!confirmed) {
      return
    }
    await carsService.deleteCar(carId)
  }
  catch (error) {
    Pop.error(error, 'Could not delete car!');
  }
}
</script>


<template>
  <div class="row shadow-lg mb-3 car-border">
    <div class="col-md-6 px-0">
      <img :src="carProp.imgUrl" :alt="`A picture of this ${carProp.year} ${carProp.make} ${carProp.model}`"
        class="w-100">
    </div>
    <div class="col-md-6">
      <div class="p-3 d-flex h-100 justify-content-between flex-column">
        <div>
          <div class="d-flex justify-content-between">
            <p class="fs-3">{{ carProp.year }} {{ carProp.make }} {{ carProp.model }}</p>
            <small>{{ carProp.createdAt.toLocaleDateString() }}</small>
          </div>
          <p class="fs-3">{{ '$' + carProp.price.toLocaleString() }}</p>
          <p v-if="carProp.description">{{ carProp.description }}</p>
          <p v-else><i>Description Unavailable</i></p>
          <p>Engine: {{ carProp.engineType }}</p>
        </div>
        <div class="d-flex justify-content-between align-items-center">
          <div>
            <button @click="deleteCar(carProp.id)" v-if="account && carProp.creator.id === account.id"
              class="btn btn-danger">Delete</button>
          </div>
          <div class="d-flex justify-content-end align-items-center gap-3">
            <p class="mb-0">{{ carProp.creator.name }}</p>
            <img :src="carProp.creator.picture" :alt="`${carProp.creator.name} profile image`" class="creator-img">
          </div>
        </div>
      </div>
    </div>
  </div>
</template>


<style lang="scss" scoped>
.creator-img {
  height: 3.7em;
  aspect-ratio: 1/1;
  border-radius: 50%;
}

img {
  height: 35dvh;
  object-fit: cover;
}

.car-border {
  border-style: solid;
  border-width: thick;
  border-color: v-bind('carProp.color');
}

p {
  text-transform: capitalize;
}
</style>