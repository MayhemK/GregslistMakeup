<script setup>
import { AppState } from '@/AppState.js';
import { House } from '@/models/House.js';
import { housesService } from '@/services/HousesService.js';
import { Pop } from '@/utils/Pop.js';
import { computed } from 'vue';

const account = computed(() => AppState.account)

defineProps({
  houseProp: { type: House, required: true }
})

async function deleteHouse(houseId) {
  try {
    const confirmed = await Pop.confirm('Are you sure you want to delete this house?', 'Action is permanent', 'Yes', 'No')
    if (!confirmed) {
      return
    }
    await housesService.deleteHouse(houseId)
  }
  catch (error) {
    Pop.error(error);
  }
}
</script>


<template>
  <div class="row shadow-lg mb-3 house-border">
    <div class="col-md-6 px-0">
      <img :src="houseProp.imgUrl" :alt="`A picture of this ${houseProp.year} ${houseProp.bedrooms} bedroom house`"
        class="w-100">
    </div>
    <div class="col-md-6">
      <div class="p-3 d-flex h-100 justify-content-between flex-column">
        <div>
          <div class="d-flex justify-content-between">
            <b class="fs-4">{{ houseProp.year }} {{ houseProp.bedrooms }} Bedroom(s) {{ houseProp.bathrooms }}
              Bathroom(s)</b>
            <small>{{ houseProp.createdAt.toLocaleDateString() }}</small>
          </div>
          <i class="fs-5">{{ houseProp.levels }} Level(s) </i>
          <p class="fs-3 fw-bold"><span>$</span>{{ houseProp.price.toLocaleString() }}</p>
          <p v-if="houseProp.description" class="fs-4">{{ houseProp.description }}</p>
          <p v-else><i>Description Unavailable</i></p>
        </div>
        <div class="d-flex justify-content-between align-items-center">
          <div>
            <button @click="deleteHouse(houseProp.id)" v-if="account && houseProp.creator.id === account.id"
              class="btn btn-danger">Delete</button>
          </div>

          <div class="d-flex justify-content-end align-items-center gap-3">
            <p class="mb-0">{{ houseProp.creator.name }}</p>
            <img :src="houseProp.creator.picture" :alt="`${houseProp.creator.name} profile image`" class="creator-img">
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

p {
  text-transform: capitalize;
}

.house-border {
  border-style: solid;
  border-width: thick;
  border-color: gray;
}
</style>