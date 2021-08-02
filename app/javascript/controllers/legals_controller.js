import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["plus", "box"]
  show(e) {
    this.boxTargets[e.currentTarget.dataset.id].classList.toggle('d-none');
    this.plusTargets[e.currentTarget.dataset.id].classList.toggle('plus-active');
  }
}
