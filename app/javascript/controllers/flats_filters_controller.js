import StimulusReflex from 'stimulus_reflex';
import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ['form']

  connect() {
    StimulusReflex.register(this)
  }

  afterReflex(e) {
  }

  filterByFacility(e) {
    const dateInput = document.querySelector('#test')
    this.stimulate('flatReflex#filter', {date: dateInput.value, element: this.formTarget})
  }
}
