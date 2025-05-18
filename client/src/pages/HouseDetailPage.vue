<script setup>
import { AppState } from '@/AppState.js';
import { housesService } from '@/services/HousesService.js';
import { Pop } from '@/utils/Pop.js';
import { computed, onMounted, ref, watch } from 'vue';
import { useRoute, useRouter } from 'vue-router';

const house = computed(() => AppState.activeHouse);
const account = computed(() => AppState.account);

const route = useRoute();
const router = useRouter();

onMounted(() => {
  getHouseById();
});

const editableHouseData = ref({
  bedrooms: '',
  bathrooms: '',
  levels: '',
  year: '',
  price: '',
  description: '',
  imgUrl: '',
  color: ''
});

watch(house, (newHouseData) => {
  if (newHouseData) {
    editableHouseData.value = {
      bedrooms: newHouseData.bedrooms || '',
      bathrooms: newHouseData.bathrooms || '',
      levels: newHouseData.levels || '',
      year: newHouseData.year || '',
      price: newHouseData.price || '',
      description: newHouseData.description || '',
      imgUrl: newHouseData.imgUrl || '',
      color: newHouseData.color || '#000000'
    };
  }
}, { immediate: true });


async function getHouseById() {
  try {
    const houseId = route.params.houseId;
    await housesService.getHouseById(houseId);
  }
  catch (error) {
    Pop.error(error.message || 'Could not fetch house details.');

  }
}

async function updateHouse() {

  try {
    const houseId = route.params.houseId;
    const updateData = editableHouseData.value;


    await housesService.updateHouse(houseId, updateData);
    Pop.success('House updated successfully!');

  }
  catch (error) {
    Pop.error(error.message || 'Could not update house.');

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

            <div class="d-flex align-items-center mb-3">
              <span class="me-2">Color:</span>
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

      <div class="container mt-4">
        <div class="row justify-content-center">
          <div class="col-12 text-center mb-3">
            <h2>Edit Listing</h2>
          </div>

          <div v-if="account && account.id === house.creator.id" class="col-md-8">
            <form @submit.prevent="updateHouse()">
              <div class="row mb-3">
                <div class="col">
                  <div class="form-floating">
                    <input v-model="editableHouseData.bedrooms" type="text" class="form-control" id="houseBedrooms"
                      placeholder="Bedrooms">
                    <label for="houseBedrooms">Bedrooms</label>
                  </div>
                </div>
                <div class="col">
                  <div class="form-floating">
                    <input v-model="editableHouseData.bathrooms" type="text" class="form-control" id="houseBathrooms"
                      placeholder="Bathrooms">
                    <label for="houseBathrooms">Bathrooms</label>
                  </div>
                </div>
                <div class="col">
                  <div class="form-floating">
                    <input v-model="editableHouseData.levels" type="text" class="form-control" id="houseLevels"
                      placeholder="Levels">
                    <label for="houseLevels">Levels</label>
                  </div>
                </div>
              </div>
              <div class="row mb-3">
                <div class="col">
                  <div class="form-floating">
                    <input v-model="editableHouseData.year" type="number" class="form-control" id="houseYear"
                      placeholder="Year"> <label for="houseYear">Year</label>
                  </div>
                </div>
                <div class="col">
                  <div class="form-floating">
                    <input v-model="editableHouseData.price" type="number" class="form-control" id="housePrice"
                      placeholder="Price"> <label for="housePrice">Price</label>
                  </div>
                </div>
              </div>
              <div class="form-floating mb-3">
                <textarea v-model="editableHouseData.description" class="form-control" id="houseDescription"
                  placeholder="Description" style="height: 100px"></textarea> <label
                  for="houseDescription">Description</label>
              </div>
              <div class="form-floating mb-3">
                <input v-model="editableHouseData.imgUrl" type="url" class="form-control" id="houseImgUrl"
                  placeholder="Image URL"> <label for="houseImgUrl">Image URL</label>
              </div>
              <div class="d-flex align-items-center justify-content-between mb-3">
                <div class="d-flex align-items-center">
                  <label for="houseColor" class="me-2">Color:</label>
                  <input v-model="editableHouseData.color" type="color" class="form-control form-control-sm"
                    id="houseColor" style="width: 50px; height: 38px; padding: 0; border: none;">
                </div>
                <button class="btn btn-outline-success" type="submit">
                  Save Changes </button>
              </div>
            </form>
          </div>
          <div v-else class="fs-5 text-center">
            Please Login to edit listing
          </div>
        </div>
      </div>
    </div>
    <div v-else class="container mt-4 text-center">
      <p>Loading house data...</p>
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