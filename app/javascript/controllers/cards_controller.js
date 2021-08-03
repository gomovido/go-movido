import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["input", "box"]
  show(e) {
    this.boxTargets[e.currentTarget.dataset.id].classList.toggle('d-none');
    this.inputTargets[e.currentTarget.dataset.id].classList.toggle('plus-active');
  }

  rotate(e) {
    document.querySelector(`i.chevron_${e.currentTarget.dataset.id}`).classList.toggle("rotate-smouth")
  }
}
