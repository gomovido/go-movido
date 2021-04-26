import { Controller } from "stimulus";
import StimulusReflex from 'stimulus_reflex';
import phoneInput from '../packs/phone-input';

export default class extends Controller {
  static targets = [ "form", 'phone']

  connect() {
    StimulusReflex.register(this);
    phoneInput(this.phoneTarget);
  }

  afterReflex() {
    this.connect();
  }

  submit(e) {
    e.preventDefault()
    this.stimulate('BookingReflex#create', this.formTarget)
  }
}
