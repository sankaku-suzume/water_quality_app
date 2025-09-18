import { Controller } from "@hotwired/stimulus"

export default class SelectController extends Controller {
  static targets = ['testItem']

  // connect() {
  //   console.log('SelectController connected')
  // }

  change(event) {
    const elements = document.querySelectorAll('.result-form_unit')
    elements.forEach(element => {
      element.classList.add('hidden')
    })
    const testItemId = event.target.value
    const unit = document.getElementById(`result-form_unit-test_item_id${testItemId}`)
    unit.classList.remove('hidden')
  }
}