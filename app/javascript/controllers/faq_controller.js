import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ "accordion"]

  connect() {
    $('#accordion').on('show.bs.collapse', (e)  => {
      e.target.previousElementSibling.lastElementChild.classList.remove('fa-plus');
      e.target.previousElementSibling.lastElementChild.classList.add('fa-minus');
    });
    $('#accordion').on('hide.bs.collapse', (e)  => {
      e.target.previousElementSibling.lastElementChild.classList.remove('fa-minus');
      e.target.previousElementSibling.lastElementChild.classList.add('fa-plus');
    });
  }
}
