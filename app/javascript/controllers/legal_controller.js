import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['box', 'plus']

  display(event) {
    this.boxTargets[event.currentTarget.dataset.id].classList.toggle('d-none')
    this.plusTargets[event.currentTarget.dataset.id].classList.toggle('plus-active')
  }

}
