import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ "button", "title" ]

  transform() {
    this.buttonTarget.classList.contains('cross') ? this.buttonTarget.classList.remove('cross') : this.buttonTarget.classList.add('cross');
  }
}
