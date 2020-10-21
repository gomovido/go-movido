import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ "menuButton", "profileButton"]

  toggleMenu() {
    this.menuButtonTarget.classList.toggle('cross');
    $('#menuModal').modal('toggle');
  }

  toggleProfile() {
    this.profileButtonTarget.classList.toggle('rotate');
  }
}
