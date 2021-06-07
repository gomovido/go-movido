import { Controller } from "stimulus";
import StimulusReflex from 'stimulus_reflex';

export default class extends Controller {

  static targets = ["contentContainer", "message"]

  connect() {
    StimulusReflex.register(this);
    this.messageTargets.forEach(message => message.classList.add('animate__animated', 'animate__fadeInLeft', `animate__delay-${message.dataset.delay}s`));
    this.contentContainerTarget.classList.add('animate__animated', 'animate__fadeInLeft', `animate__delay-${this.contentContainerTarget.dataset.delay}s`)
  }

  afterReflex() {
    this.connect();
  }
}
