import ApplicationController from './application_controller.js'
import phoneInput from '../packs/phone-input';
import StimulusReflex from 'stimulus_reflex';
import {addressAutocomplete, searchByCity, searchByCountry, autoFill} from '../packs/algolia';
const places = require('places.js');

export default class extends ApplicationController {
  static targets = ['phone', 'input', 'addressInput', 'addAddressInput', 'addAddressButton', 'birthCity', 'errors'];
  static classes = [ 'hide', 'flex', 'readonly' ]

  connect() {
    StimulusReflex.register(this);
    this.birthCity = addressAutocomplete(this.birthCityTarget);
    searchByCity(this.birthCity);
    phoneInput(this.phoneTarget);
    this.phoneTarget.value = document.getElementById('user_phone').value;
  }

  updateNavbar(event) {
    if (event.target.value) {
      document.getElementById('profileNavbar').innerText = document.getElementById('user_first_name').value + ' ' + document.getElementById('user_last_name').value;
    }
  }

  afterReflex(event, response, error) {
    if (error) {
      this.errorsTarget.innerHTML = "";
      this.errorsTarget.insertAdjacentHTML('beforeend', error);
    } else {
      this.connect();
    }
  }


  toggleAddressAutocomplete() {
    this.movingStreet = addressAutocomplete(this.addressInputTarget);
    searchByCountry(this.movingStreet, ['FR', 'GB']);
    autoFill(this.movingStreet);
    this.addAddressInputTarget.classList.remove(this.hideClass);
    this.addAddressInputTarget.classList.add(this.flexClass);
    this.addAddressButtonTarget.classList.add(this.hideClass);
    this.addAddressButtonTarget.classList.remove(this.flexClass);
  }
}
