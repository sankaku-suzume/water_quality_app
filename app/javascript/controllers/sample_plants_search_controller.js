import { Controller } from "@hotwired/stimulus"

export default class SamplePlantsSearchController extends Controller {
  // static targets = ['select']

  // connect() {
  //   this.moveSearchBox()
  // }

  show() {
    const element = document.querySelector('.samples_plants-search_drop-down')
    element.classList.remove('hidden')
  }

  hide() {
    const element = document.querySelector('.samples_plants-search_drop-down')
    element.classList.add('hidden')
  }

  get_value(event) {
    const plantId = event.currentTarget.dataset.plantId
    const element = document.querySelector('#sample_plant_id')
    element.value = plantId
  }
}