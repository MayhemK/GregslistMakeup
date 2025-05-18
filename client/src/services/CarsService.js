import { logger } from "@/utils/Logger.js"
import { api } from "./AxiosService.js"
import { AppState } from "@/AppState.js"
import { Car } from "@/models/Car.js"
import { router } from "@/router.js"

class CarsService {
  async updateCar(carId, updateData) {
    const res = await api.put(`api/cars/${carId}`, updateData)
    AppState.activeCar = new Car(res.data)
  }
  async getCarById(carId) {
    AppState.activeCar = null
    const res =await api.get(`api/cars/${carId}`)
    const car = new Car(res.data)
    AppState.activeCar = car
  }
  async deleteCar(carId) {
    const res = await api.delete(`api/cars/${carId}`)
    logger.log('Car Deleted', res.data)
    const cars = AppState.cars
    const carIndex = cars.findIndex(car => car.id == carId)
    cars.splice(carIndex, 1)
    router.push({ name: 'Cars' })
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