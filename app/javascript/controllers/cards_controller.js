import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["input", "box"]
  show(e) {
    this.boxTargets[e.currentTarget.dataset.id].classList.toggle('d-none');
    this.inputTargets[e.currentTarget.dataset.id].classList.toggle('plus-active');
  }

  displayFullDescription(e) {
    this.boxTargets.filter(target => target.dataset.id === e.currentTarget.dataset.id)[0].classList.toggle('d-none')
  }

  rotate(e) {
    document.querySelector(`i.chevron_${e.currentTarget.dataset.id}`).classList.toggle("rotate-smouth")
  }
}
