<script setup>
import { AppState } from '@/AppState.js';
import { housesService } from '@/services/HousesService.js';
import { Pop } from '@/utils/Pop.js';
import { computed, onMounted } from 'vue';
import { useRoute } from 'vue-router';

const house = computed(() => AppState.activeHouse)
const route = useRoute()
onMounted(() => {
  getHouseById()
})

async function getHouseById() {

  try {
    const houseId = route.params.houseId
    await housesService.getHouseById(houseId)
  }
  catch (error) {
    Pop.error(error);
  }
}
</script>


<template>
  <div>
    <div v-if="house">
      <section class="container">
        <div class="row">
          <div class="col-12">
            <img :src="house.imgUrl" :alt="`Image of ${house.description || 'the house'}`" class="w-100">
          </div>
        </div>
        <div class="row mt-3">
          <div class="col-md-6">
            <h3>Description:</h3>
            <p v-if="house.description">{{ house.description }}</p>
            <p v-else><i>No description available.</i></p>

            <div class="d-flex align-items-center mb-3"> <span class="me-2">Color:</span>
              <template v-if="house.color">
                <div class="color-swatch me-2" :style="{ backgroundColor: house.color }"></div>
              </template>
              <template v-else>
                <span>Unspecified</span>
              </template>
            </div>
          </div>

          <div class="col-md-6">
            <h3>Details:</h3>
            <p> Bedrooms: {{ house.bedrooms }}</p>
            <p> Bathrooms: {{ house.bathrooms }}</p>
            <p>Levels: {{ house.levels }}</p>
            <p>Year Built: {{ house.year }}</p>
            <p class="fs-3 fw-bold">Price: <span>$</span>{{ house.price?.toLocaleString() || 'N/A' }}</p>


          </div>
        </div>
      </section>
    </div>
    <div v-else>
      <p>Loading...</p>
    </div>
  </div>
</template>


<style lang="scss" scoped>
.color-swatch {
  width: 20px;
  height: 20px;
  border: 1px solid #ccc;
  display: inline-block;
  vertical-align: middle;
  border-radius: 4px;
}
</style>