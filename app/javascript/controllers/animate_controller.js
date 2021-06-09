import { Controller } from "stimulus";
import StimulusReflex from 'stimulus_reflex';

export default class extends Controller {

  static targets = ["contentContainer", "message"]

  connect() {
    StimulusReflex.register(this);
    window.scroll({ top: 0, behavior: 'smooth' });
    this.messageTargets.forEach(message => message.classList.add('animate__animated', 'animate__fadeInLeft', `animate__delay-${message.dataset.delay}s`));
    if (document.querySelector('.spinner-container')) {
      document.querySelector('.spinner-container').classList.add('animate__animated', 'animate__fadeInLeft', `animate__delay-${document.querySelector('.spinner-container').dataset.delay}s`)
      setTimeout(e => document.querySelector('.spinner-container').classList.add('animate__animated', 'animate__fadeOutRight'), 2000)
    }
    this.contentContainerTarget.classList.add('animate__animated', 'animate__fadeInLeft', `animate__delay-${this.contentContainerTarget.dataset.delay}s`);
  }

  afterReflex() {
    this.connect();
  }

  toggleInputs() {
    document.querySelector('.inputs').classList.toggle('d-none')
  }
}
