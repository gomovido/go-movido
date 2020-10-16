import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ "button", "title"]

  toggle() {
    this.buttonTarget.classList.toggle('cross');
    $('#exampleModal').modal('toggle');
  }
}
