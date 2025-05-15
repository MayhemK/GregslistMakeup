import { logger } from "@/utils/Logger.js"
import { api } from "./AxiosService.js"

class HousesService {
  async getHouses() {
    const res = await api.get('api/houses')
    logger.log('Got Houses!', res.data)
  }

}

export const housesService = new HousesService()