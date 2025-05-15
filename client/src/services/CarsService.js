import { logger } from "@/utils/Logger.js"
import { api } from "./AxiosService.js"
import { AppState } from "@/AppState.js"
import { Car } from "@/models/Car.js"

class CarsService {
  async getCars() {
    const res = await api.get('api/cars')
    logger.log('Got cars!', res.data)
    const cars = res.data.map(pojo => new Car(pojo))
    AppState.cars = cars
  }
  
}

export const carsService = new CarsService()