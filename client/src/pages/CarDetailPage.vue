<script setup>
import { AppState } from '@/AppState.js';
import { carsService } from '@/services/CarsService.js';
import { Pop } from '@/utils/Pop.js';
import { computed, onMounted, ref, watch } from 'vue';
import { useRoute } from 'vue-router';


const car = computed(() => AppState.activeCar);
const account = computed(() => AppState.account);

const route = useRoute();

onMounted(() => {
  getCarById();
});

const editableCarData = ref({
  make: '',
  model: '',
  year: '',
  color: '#000000',
  price: 0,
  mileage: '',
  engineType: 'unknown',
  imgUrl: '',
  hasCleanTitle: false,
  description: ''
});

watch(car, (newCarData) => {
  if (newCarData) {
    editableCarData.value = {
      make: newCarData.make || '',
      model: newCarData.model || '',
      year: newCarData.year || '',
      color: newCarData.color || '#000000',
      price: newCarData.price || 0,
      mileage: newCarData.mileage || '',
      engineType: newCarData.engineType || 'unknown',
      imgUrl: newCarData.imgUrl || '',
      hasCleanTitle: newCarData.hasCleanTitle || false,
      description: newCarData.description || ''
    };
  }
}, { immediate: true });

async function getCarById() {
  try {
    const carId = route.params.carId;
    await carsService.getCarById(carId);
  }
  catch (error) {
    Pop.error(error);
  }
}

async function updateCar() {
  try {
    const carId = route.params.carId;
    const updateData = editableCarData.value;
    await carsService.updateCar(carId, updateData);
    Pop.success('Car updated successfully!');
  }
  catch (error) {
    Pop.error(error);
  }
}

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
  <div>
    <div v-if="car">
      <section class="container">
        <div class="row">
          <div class="col-12">
            <img :src="car.imgUrl" :alt="`Image of ${car.year} ${car.make} ${car.model}`" class="w-100">
          </div>
        </div>
        <div class="row mt-3">
          <div class="col-md-6">
            <h3>Description:</h3>
            <p v-if="car.description">{{ car.description }}</p>
            <p v-else><i>No description available.</i></p>
            <div class="d-flex align-items-center mb-3">
              <span class="me-2">Color:</span>
              <template v-if="car.color">
                <div class="color-swatch me-2" :style="{ backgroundColor: car.color }"></div>
              </template>
              <template v-else>
                <span>Unspecified</span>
              </template>
            </div>
            <p>Engine Type: {{ car.engineType || 'Unknown' }}</p>
            <p>Clean Title: {{ car.hasCleanTitle ? 'Yes' : 'No' }}</p>
            <div class="d-flex justify-content-center mt-5">
              <button @click="deleteCar(car.id)" v-if="account && car.creator.id === account.id"
                class="btn btn-danger">Delete</button>
            </div>
          </div>
          <div class="col-md-6">
            <h3>Details:</h3>
            <p>Make: {{ car.make }}</p>
            <p>Model: {{ car.model }}</p>
            <p>Year: {{ car.year }}</p>
            <p>Mileage: {{ car.mileage?.toLocaleString() || 'N/A' }}</p>
            <p class="fs-3 fw-bold">Price: <span>$</span>{{ car.price?.toLocaleString() || 'N/A' }}</p>
          </div>
        </div>
      </section>
      <div class="container mt-4" v-if="car && account && account.id === car.creatorId">
        <div class="row justify-content-center">
          <div class="col-12 text-center mb-3">
            <h2>Edit Car Listing</h2>
          </div>
          <div class="col-md-8">
            <form @submit.prevent="updateCar()">
              <div class="row mb-3">
                <div class="col">
                  <div class="form-floating ">
                    <input v-model="editableCarData.year" type="number" class="form-control" id="carYear"
                      placeholder="">
                    <label for="carYear">Year</label>
                  </div>
                </div>
                <div class="col">
                  <div class="form-floating ">
                    <input v-model="editableCarData.make" type="text" class="form-control" id="carMake" placeholder="">
                    <label for="carMake">Make</label>
                  </div>
                </div>
                <div class="col">
                  <div class="form-floating ">
                    <input v-model="editableCarData.model" type="text" class="form-control" id="carModel"
                      placeholder="">
                    <label for="carModel">Model</label>
                  </div>
                </div>
              </div>
              <div class="row mb-3">
                <div class="col">
                  <div class="form-floating ">
                    <input v-model="editableCarData.price" type="number" class="form-control" id="carPrice"
                      placeholder="">
                    <label for="carPrice">Price</label>
                  </div>
                </div>
                <div class="col">
                  <div class="form-floating ">
                    <input v-model="editableCarData.mileage" type="number" class="form-control" id="carMileage"
                      placeholder="">
                    <label for="carMileage">Mileage</label>
                  </div>
                </div>
              </div>
              <div class="form-floating mb-3">
                <textarea v-model="editableCarData.description" type="text" class="form-control" id="carDescription"
                  placeholder=""></textarea>
                <label for="carDescription">Description</label>
              </div>
              <div class="form-floating mb-3">
                <input v-model="editableCarData.imgUrl" type="url" class="form-control" id="carImgUrl" placeholder="">
                <label for="carImgUrl">Image URL</label>
              </div>
              <div class="form-floating mb-3">
                <select v-model="editableCarData.engineType" type="text" class="form-select" id="carEngine">
                  <option value="">--Engine Type Select--</option>
                  <option value="small">small</option>
                  <option value="medium">medium</option>
                  <option value="large">large</option>
                  <option value="super-size">super-size</option>
                  <option value="battery">battery</option>
                </select>
                <label for="carEngine">Engine Type</label>
              </div>
              <div class="d-flex align-items-center justify-content-between mb-3">
                <div class="d-flex align-items-center">
                  <label for="carColor" class="me-2">Color:</label>
                  <input v-model="editableCarData.color" type="color" class="form-control form-control-sm" id="carColor"
                    style="width: 50px; height: 38px; padding: 0; border: none;">
                </div>
                <div class="form-check">
                  <input v-model="editableCarData.hasCleanTitle" class="form-check-input" type="checkbox"
                    id="cleanTitleCheck">
                  <label class="form-check-label" for="cleanTitleCheck">
                    Clean Title?
                  </label>
                </div>
                <button class="btn btn-outline-success" type="submit">
                  Save Changes
                </button>
              </div>
              <div></div>
            </form>
          </div>
        </div>
      </div>
    </div>
    <div v-else class="container mt-4 text-center">
      <p>Loading car data...</p>
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