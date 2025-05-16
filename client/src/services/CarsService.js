import { logger } from "@/utils/Logger.js"
import { api } from "./AxiosService.js"
import { AppState } from "@/AppState.js"
import { Car } from "@/models/Car.js"
import App from "@/App.vue"

class CarsService {
  async deleteCar(carId) {
    const res = await api.delete(`api/cars/${carId}`)
    logger.log('Car Deleted', res.data)
    const cars = AppState.cars
    const carIndex = cars.findIndex(car => car.id == carId)
    cars.splice(carIndex, 1)
  }
  async createCar(carData) {
    const res = await api.post('api/cars', carData)
    const car = new Car(res.data)
    AppState.cars.push(car)
  }
  async getCars() {
    const res = await api.get('api/cars')
    logger.log('Got cars!', res.data)
    const cars = res.data.map(pojo => new Car(pojo))
    AppState.cars = cars
  }
  
}

export const carsService = new CarsService()