import Flatpickr from "stimulus-flatpickr";
import StimulusReflex from 'stimulus_reflex';

export default class extends Flatpickr {
  connect() {
    StimulusReflex.register(this);
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

  afterReflex(e) {
    this.connect();
    document.querySelector('.spinner-container').classList.add('d-none')
    document.querySelector('.flats-card-wrapper').classList.remove('opacity')
  }

  filterByDates(e) {
    if (e.currentTarget.value.split(' ').length === 3) {
      document.querySelector('.spinner-container').classList.remove('d-none')
      document.querySelector('.flats-card-wrapper').classList.add('opacity')
      this.stimulate('Flat#filter_by_dates', e.currentTarget)
    }
  }
}
