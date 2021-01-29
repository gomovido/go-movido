import Flatpickr from "stimulus-flatpickr";
import "flatpickr/dist/themes/dark.css";

export default class extends Flatpickr {
  connect() {
    super.connect();
    let field = document.querySelector('.flatpickr-mobile');
    if (field) {
      field.addEventListener('change', e => {
        if (field.value) {
            field.placeholder = ''
        } else {
            field.placeholder = 'DD/MM/YYYY'
        }
      });
    }
  }
}
