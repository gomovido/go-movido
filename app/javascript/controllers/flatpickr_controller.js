import Flatpickr from "stimulus-flatpickr";

export default class extends Flatpickr {
  connect() {
    this.config = { locale: { rangeSeparator: ' - ' } };
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
