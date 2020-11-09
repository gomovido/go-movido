import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ "menuButton", "profileButton"]

  connect() {
    $('.profile-dropdown').on('hide.bs.dropdown', e => {
    if (e.clickEvent) {
      e.preventDefault();
    }
  })
  }

  toggleMenu() {
    this.menuButtonTarget.classList.toggle('cross');
    $('#menuModal').modal('toggle');
  }

  toggleProfile() {
    this.profileButtonTarget.classList.toggle('rotate');
  }
}
