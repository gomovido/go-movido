import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ "menuButton"]
  static classes = [ "cross" ]

  toggleMenu() {
    this.menuButtonTarget.classList.toggle(this.crossClass);
    $('#menuModal').modal('toggle');
  }
}
