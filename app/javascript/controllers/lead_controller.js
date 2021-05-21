import { Controller } from "stimulus";
import StimulusReflex from 'stimulus_reflex';

export default class extends Controller {
  static targets = [ 'button', 'form']

  connect() {
    StimulusReflex.register(this);
  }

  beforeReflex() {
    this.buttonTarget.value = 'Processing...'
  }

  reflexSuccess() {
    setTimeout(e => {
      this.buttonTarget.style.background = '#2FAB73';
      this.buttonTarget.value = "Congrats ! We'll contact you very soon";
    }, 2000)
  }


  reflexError() {
    setTimeout(e => {
      this.buttonTarget.style.background = '#FF6C6C';
      this.buttonTarget.value = 'Invalid email, try again !';
    }, 2000)
  }

  submit(e) {
    e.preventDefault();
    this.stimulate('LeadReflex#submit', this.formTarget)
  }
}
