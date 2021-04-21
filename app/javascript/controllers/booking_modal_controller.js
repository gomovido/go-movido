import { Controller } from "stimulus";
import StimulusReflex from 'stimulus_reflex';


export default class extends Controller {
  static targets = [ "form"]

  connect() {
    StimulusReflex.register(this);
  }

  submit(e) {
    this.stimulate('BookingReflex#create', this.formTarget)
      .then((response) => {
        console.log('then')
        console.log(response)
      });
  }
}
