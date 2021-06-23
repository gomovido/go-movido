import { Controller } from "stimulus";
import StimulusReflex from 'stimulus_reflex';

export default class extends Controller {
  static targets = [ 'button']

  connect() {
    StimulusReflex.register(this);
  }

  beforeReflex() {
    this.buttonTarget.innerText = 'Processing...'
  }

  reflexSuccess() {
    setTimeout(e => {
      this.buttonTarget.style.background = '#2FAB73';
      this.buttonTarget.innerText = "Congrats! We'll contact you very soon";
    }, 2000)
  }


  reflexHalted() {
    setTimeout(e => {
      this.buttonTarget.style.background = '#FF6C6C';
      this.buttonTarget.innerText = 'You are already pre-registered';
    }, 2000)
  }

  submit(e) {
    this.buttonTarget.style.background = '#8C30F5';
    this.stimulate('LeadReflex#submit')
  }
}
