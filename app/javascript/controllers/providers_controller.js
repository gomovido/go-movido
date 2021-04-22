import { Controller } from "stimulus"
import Rails from "@rails/ujs";
import StimulusReflex from 'stimulus_reflex';

export default class extends Controller {
  static targets = ["spinner", "form", "wrapper"]

  connect() {
    StimulusReflex.register(this)
  }

  afterReflex(e) {
    this.hideLoading(this.spinnerTarget, this.wrapperTarget)
    this.connect()
  }

  filterByDates(e) {
    if (e.currentTarget.value.split(' ').length === 3) {
      this.triggerLoading(this.spinnerTarget, this.wrapperTarget, this.formTarget, e.currentTarget.value)
    }
  }

  triggerLoading(spinner, wrapper, form, date) {
    document.querySelector('.flat_preference_move_in').classList.add('disabled');
    spinner.classList.remove('d-none');
    spinner.classList.add('middle');
    wrapper.classList.add('opacity')
    this.stimulate('ProviderReflex#filter', form, date)

  }

  hideLoading(spinner, wrapper) {
    spinner.classList.add('d-none');
    spinner.classList.remove('middle');
    wrapper.classList.remove('opacity');
    document.querySelector('.flat_preference_move_in').classList.remove('disabled');

  }

  addGradient(e) {
    let imageUrl = e.currentTarget.dataset.image
    e.currentTarget.style.backgroundImage = `linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.3)), url(${imageUrl})`
  }

  removeGradient(e) {
    let imageUrl = e.currentTarget.dataset.image
    e.currentTarget.style.backgroundImage = `url(${imageUrl})`
  }

}
