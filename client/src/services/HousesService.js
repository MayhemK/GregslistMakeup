import { logger } from "@/utils/Logger.js"
import { api } from "./AxiosService.js"
import { AppState } from "@/AppState.js"
import { House } from "@/models/House.js"

class HousesService {
  createHouse(houseData) {
    throw new Error('Method not implemented.')
  }
  async getHouses() {
    const res = await api.get('api/houses')
    logger.log('Got Houses!', res.data)
    const houses = res.data.map(pojo => new House(pojo))
    AppState.houses = houses
  }

}

export const housesService = new HousesService()