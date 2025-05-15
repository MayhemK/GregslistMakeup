import { logger } from "@/utils/Logger.js"
import { api } from "./AxiosService.js"

class CarsService {
  async getCars() {
    const res = await api.get('api/cars')
    logger.log('Got cars!', res.data)
  }
  
}

export const carsService = new CarsService()