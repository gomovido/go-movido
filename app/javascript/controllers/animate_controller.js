import { Controller } from "stimulus";
import StimulusReflex from 'stimulus_reflex';

export default class extends Controller {

  static targets = ["contentContainer", "message"]

  connect() {
    StimulusReflex.register(this);
    window.scroll({ top: 0, behavior: 'smooth' });
    this.toggleSpinner(document.querySelector('.spinner-container'), 2000)
    if (document.querySelector('.chat-container')) {
      this.messageTarget.classList.add('animate__animated', 'animate__fadeInLeft', `animate__delay-${this.messageTarget.dataset.delay}s`)
    }
    this.contentContainerTarget.classList.add('animate__animated', 'animate__fadeInLeft', `animate__delay-${this.contentContainerTarget.dataset.delay}s`);
  }

  afterReflex() {
    this.connect();
  }

  toggleInputs() {
    document.querySelector('.inputs').classList.toggle('d-none')
  }

  toggleSpinner(spinner, spinner_duration) {
    if (spinner) {
      spinner.classList.add('animate__animated', 'animate__fadeInLeft', `animate__delay-${spinner.dataset.delay}s`)
      setTimeout(e => {
        spinner.classList.add('animate__fadeOutRight');
        this.messageTarget.classList.add('animate__fadeOutRight', `animate__delay-1s`);
        setTimeout(e => this.stimulate('CartReflex#generate_packs'), 2600)
      }, spinner_duration)

    }
  }
}
