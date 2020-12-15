import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ "menuButton"]

  toggleMenu() {
    this.menuButtonTarget.classList.toggle('cross');
    $('#menuModal').modal('toggle');
  }
}
