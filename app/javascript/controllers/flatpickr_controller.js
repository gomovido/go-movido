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
    let old_url = document.querySelector("a[rel='next']").getAttribute("href");
    document.querySelector("a[rel='next']").href = old_url.replace(/.$/,"2")
    document.querySelector('.spinner-container').classList.add('d-none');
    document.querySelector('.spinner-container').classList.remove('middle');
    document.querySelector('.flats-card-wrapper').classList.remove('opacity');
    document.querySelector('.dates_dates').classList.remove('disabled');

  }

  filterByDates(e) {
    if (e.currentTarget.value.split(' ').length === 3) {
      document.querySelector('.dates_dates').classList.add('disabled');
      document.querySelector('.spinner-container').classList.remove('d-none')
      document.querySelector('.spinner-container').classList.add('middle');
      document.querySelector('.flats-card-wrapper').classList.add('opacity');
      this.stimulate('Flat#filter', e.currentTarget);
    }
  }
}
