import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ "firstStep", "secondStep"]

  nextStep(event) {
    setTimeout(() => {
      this.firstStepTarget.classList.add('d-none');
      this.secondStepTarget.classList.remove('d-none');
    }, 50);
  }
}
