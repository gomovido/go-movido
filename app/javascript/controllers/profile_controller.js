import ApplicationController from './application_controller.js'
import phoneInput from '../packs/phone-input';
import StimulusReflex from 'stimulus_reflex';
import {addressAutocomplete, searchByCity, searchByCountry, autoFill} from '../packs/algolia';
const places = require('places.js');

export default class extends ApplicationController {
  static targets = ['phone', 'input', 'addressInput', 'addAddressInput', 'addAddressButton', 'birthCity', 'errors'];
  static classes = [ 'hide', 'flex', 'readonly' ]
  static values = { locale: String }

  connect() {
    console.log(this.localeValue)
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
      let errors = this.localeValue === 'fr' ? error.replace("La validation a échoué : ", "").replace(/,/g, '<br>') : error.replace("Validation failed: ", "").replace(/,/g, '<br>');
      this.errorsTarget.innerHTML = "";
      this.errorsTarget.insertAdjacentHTML('beforeend', errors);
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
