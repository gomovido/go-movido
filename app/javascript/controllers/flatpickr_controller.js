import Flatpickr from "stimulus-flatpickr";
import "flatpickr/dist/themes/dark.css";

export default class extends Flatpickr {
  static targets = ['flatpickr']

  connect() {
    if (document.querySelector('.flatpickr-mobile')) {
      document.querySelector('.flatpickr-mobile').addEventListener('change', e => {
        document.querySelector('.flatpickr-mobile').placeholder = '';
      });
    }
  }
}
