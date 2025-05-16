import { logger } from "@/utils/Logger.js"
import { api } from "./AxiosService.js"
import { AppState } from "@/AppState.js"
import { House } from "@/models/House.js"

class HousesService {
  async createHouse(houseData) {
    const res = await api.post('api/houses', houseData)
    const house = new House(res.data)
    AppState.houses.push(house)
  }
  async getHouses() {
    const res = await api.get('api/houses')
    logger.log('Got Houses!', res.data)
    const houses = res.data.map(pojo => new House(pojo))
    AppState.houses = houses
  }

}

export const housesService = new HousesService()