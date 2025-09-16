import { Controller } from "@hotwired/stimulus"

export default class SelectController extends Controller {
  static targets = ['testItem']

  connect() {
    console.log('SelectController connected')
  }

  change(event) {
    console.log("changeイベントが呼ばれた！")

  }
}