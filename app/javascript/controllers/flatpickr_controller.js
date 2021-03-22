import Flatpickr from "stimulus-flatpickr";
import "flatpickr/dist/themes/dark.css";
import StimulusReflex from 'stimulus_reflex';

export default class extends Flatpickr {
  connect() {
    StimulusReflex.register(this);
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

  afterReflex(e) {
    this.connect();
  }
}
