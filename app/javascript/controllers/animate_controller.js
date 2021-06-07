import { Controller } from "stimulus";
import StimulusReflex from 'stimulus_reflex';

export default class extends Controller {

  static targets = ["form", "message"]

  connect() {
    StimulusReflex.register(this);
    this.messageTargets.forEach(message => message.classList.add('animate__animated', 'animate__fadeInLeft', `animate__delay-${message.dataset.delay}s`));
    this.formTarget.classList.add('animate__animated', 'animate__fadeInLeft', `animate__delay-${this.formTarget.dataset.delay}s`)
  }

  afterReflex() {
    this.connect();
  }
}
