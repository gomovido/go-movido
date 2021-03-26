import StimulusReflex from 'stimulus_reflex';
import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ['form']

  connect() {
    StimulusReflex.register(this)
  }

  afterReflex(e) {
    let old_url = document.querySelector("a[rel='next']").getAttribute("href");
    document.querySelector("a[rel='next']").href = old_url.replace(/.$/,"2")
    document.querySelector('.spinner-container').classList.add('d-none');
    document.querySelector('.spinner-container').classList.remove('middle');
    document.querySelector('.flats-card-wrapper').classList.remove('opacity');
  }

  filterByFacility(e) {
    const dateValue = document.getElementById('date-input').value
    document.querySelector('.spinner-container').classList.remove('d-none')
    document.querySelector('.spinner-container').classList.add('middle');
    document.querySelector('.flats-card-wrapper').classList.add('opacity');
    this.stimulate('flatReflex#filter', this.formTarget, dateValue )
  }
}
