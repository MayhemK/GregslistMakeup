<script setup>
import { computed, ref } from 'vue';
import HouseForm from './HouseForm.vue';
import { housesService } from '@/services/HousesService.js';
import { Pop } from '@/utils/Pop.js';
import { AppState } from '@/AppState.js';

const house = computed(() => AppState.houses)

const editableHouseData = ref({
  bedrooms: '',
  bathrooms: '',
  levels: '',
  year: '',
  price: '',
  description: '',
  imgUrl: '',
  color: ''
})

async function updateHouse(houseId) {
  try {
    await housesService.updateHouse(houseId)
  }
  catch (error) {
    Pop.error(error);
  }
}
</script>


<template>
  <div class="modal fade" id="updateHouse" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h1 class="modal-title fs-5" id="exampleModalLabel">Update House Listing</h1>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
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
                    placeholder="">
                  <label for="houseYear">Year</label>
                </div>
              </div>
              <div class="col">
                <div class="form-floating">
                  <input v-model="editableHouseData.price" type="number" class="form-control" id="housePrice"
                    placeholder="">
                  <label for="housePrice">Price</label>
                </div>
              </div>
            </div>
            <div class="form-floating mb-3">
              <textarea v-model="editableHouseData.description" type="text" class="form-control" id="houseDescription"
                placeholder=""></textarea>
              <label for="houseDescription">Description</label>
            </div>
            <div class="form-floating mb-3">
              <input v-model="editableHouseData.imgUrl" type="url" class="form-control" id="houseImgUrl" placeholder="">
              <label for="houseImgUrl">Image URL</label>
            </div>
            <div class="d-flex align-items-center justify-content-between mb-3">
              <div class="d-flex align-items-center">
                <label for="carColor" class="me-2">Color:</label>
                <input v-model="editableHouseData.color" type="color" class="form-control form-control-sm" id="carColor"
                  style="width: 50px; height: 38px; padding: 0; border: none;">
              </div>
              <button class="btn btn-outline-success" type="submit">
                Update
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>


<style lang="scss" scoped></style>