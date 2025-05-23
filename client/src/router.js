import { createRouter, createWebHashHistory } from 'vue-router'
import { authGuard } from '@bcwdev/auth0provider-client'

function loadPage(page) {
  return () => import(`./pages/${page}.vue`)
}

const routes = [
  {
    path: '/',
    name: 'Home',
    component: loadPage('HomePage')
  },
  {
    path: '/about',
    name: 'About',
    component: loadPage('AboutPage')
  },
  {
    path: '/cars',
    name: 'Cars',
    component: loadPage('CarsPage')
  },
  {
    path: '/cars/:carId',
    name: 'CarDetails',
    component: loadPage('CarDetailPage')
  },
  {
    path: '/houses',
    name: 'Houses',
    component: loadPage('HousesPage')
  },
  {
    path: '/houses/:houseId',
    name: 'HouseDetails',
    component: loadPage('HouseDetailPage')
  },
  {
    path: '/account',
    name: 'Account',
    component: loadPage('AccountPage'),
    beforeEnter: authGuard
  }
]

export const router = createRouter({
  linkActiveClass: 'router-link-active',
  linkExactActiveClass: 'router-link-exact-active',
  history: createWebHashHistory(),
  routes
})
