import { Controller } from "stimulus";
import StimulusReflex from "stimulus_reflex";

export default class extends Controller {
  static targets = [ "card"]

  connect() {
    StimulusReflex.register(this);
  }

  selectService(e) {
    Array.prototype.forEach.call(document.getElementsByClassName('card-service'), function(e) {
      e.classList.remove('active')
      e.classList.add('small')
    });
    Array.prototype.forEach.call(document.getElementsByClassName('description'), function(e) {
      e.classList.add('d-none')
    });
    e.currentTarget.classList.toggle('active')
    document.getElementById('dialog').classList.add('active')
    this.stimulate("DashboardReflex#add_service_modal",  e.currentTarget.dataset.id)
  }


}
