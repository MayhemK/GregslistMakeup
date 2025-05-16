<script setup>
import { carsService } from '@/services/CarsService.js';
import { Pop } from '@/utils/Pop.js';
import { ref } from 'vue';


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
})

async function createCar() {
  try {
    const carData = editableCarData.value
    await carsService.createCar(carData)
    editableCarData.value = {
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
    }
  }
  catch (error) {
    Pop.error(error, 'could not create car');
  }
}
</script>


<template>
  <form @submit.prevent="createCar()">
    <div class="row mb-3">
      <div class="col">
        <div class="form-floating ">
          <input v-model="editableCarData.year" type="number" class="form-control" id="carYear" placeholder="">
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
          <input v-model="editableCarData.model" type="text" class="form-control" id="carModel" placeholder="">
          <label for="carModel">Model</label>
        </div>
      </div>
    </div>
    <div class="row mb-3">
      <div class="col">
        <div class="form-floating ">
          <input v-model="editableCarData.price" type="number" class="form-control" id="carPrice" placeholder="">
          <label for="carPrice">Price</label>
        </div>
      </div>
      <div class="col">
        <div class="form-floating ">
          <input v-model="editableCarData.mileage" type="number" class="form-control" id="carMileage" placeholder="">
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
        <option value="unknown">Unknown</option>
        <option value="2 stroke">2 Stroke</option>
        <option value="4 cylinder">4 cylinder</option>
        <option value="v6">v6</option>
        <option value="v8">v8</option>
        <option value="v10">v10</option>
        <option value="v12">v12</option>
        <option value="small">small</option>
        <option value="medium">medium</option>
        <option value="large">large</option>
        <option value="chuncko">chuncko</option>
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
        <input v-model="editableCarData.hasCleanTitle" class="form-check-input" type="checkbox" id="cleanTitleCheck">
        <label class="form-check-label" for="cleanTitleCheck">
          Clean Title?
        </label>
      </div>
      <button class="btn btn-outline-success" type="submit">
        Submit
      </button>
    </div>
    <div></div>
  </form>
</template>


<style lang="scss" scoped></style>