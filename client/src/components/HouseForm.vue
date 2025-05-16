<script setup>
import { housesService } from '@/services/HousesService.js';
import { Pop } from '@/utils/Pop.js';
import { ref } from 'vue';


const editableHouseData = ref({
  bedrooms: '',
  bathrooms: '',
  levels: '',
  year: '',
  price: 0,
  description: '',
  imgUrl: '',
  color: '#000000'
})

async function createHouse() {
  try {
    const houseData = editableHouseData.value
    await housesService.createHouse(houseData)
    editableHouseData.value = {
      bedrooms: '',
      bathrooms: '',
      levels: '',
      year: '',
      price: 0,
      description: '',
      imgUrl: '',
      color: '#000000'
    }
  }
  catch (error) {
    Pop.error(error, 'could not create house');
  }
}
</script>


<template>
  <form>
    <div class="row mb-3">
      <div class="col">
        <div class="form-floating">
          <input type="text" class="form-control" id="houseBedrooms" placeholder="Bedrooms">
          <label for="houseBedrooms">Bedrooms</label>
        </div>
      </div>
      <div class="col">
        <div class="form-floating">
          <input type="text" class="form-control" id="houseBathrooms" placeholder="Bathrooms">
          <label for="houseBathrooms">Bathrooms</label>
        </div>
      </div>
      <div class="col">
        <div class="form-floating">
          <input type="text" class="form-control" id="houseLevels" placeholder="Levels">
          <label for="houseLevels">Levels</label>
        </div>
      </div>
    </div>
    <div class="row mb-3">
      <div class="col">
        <div class="form-floating">
          <input type="number" class="form-control" id="houseYear" placeholder="">
          <label for="houseYear">Year</label>
        </div>
      </div>
      <div class="col">
        <div class="form-floating">
          <input type="number" class="form-control" id="housePrice" placeholder="">
          <label for="housePrice">Price</label>
        </div>
      </div>
    </div>
    <div class="form-floating mb-3">
      <textarea type="text" class="form-control" id="houseDescription" placeholder=""></textarea>
      <label for="houseDescription">Description</label>
    </div>
    <div class="form-floating mb-3">
      <input type="url" class="form-control" id="houseImgUrl" placeholder="">
      <label for="houseImgUrl">Image URL</label>
    </div>
    <div class="d-flex align-items-center justify-content-between mb-3">
      <div class="d-flex align-items-center">
        <label for="carColor" class="me-2">Color:</label>
        <input type="color" class="form-control form-control-sm" id="carColor"
          style="width: 50px; height: 38px; padding: 0; border: none;">
      </div>
      <button class="btn btn-outline-success" type="submit">
        Submit
      </button>
    </div>
  </form>
</template>


<style lang="scss" scoped></style>