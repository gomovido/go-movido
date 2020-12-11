import ApplicationController from './application_controller'
import phoneInput from '../packs/phone-input';
import {addressAutocomplete, searchByCity, searchByCountry, autoFill} from '../packs/algolia';
const places = require('places.js');

export default class extends ApplicationController {
  static targets = ['phone', 'input', 'addressInput', 'addAddressInput', 'addAddressButton', 'birthCity'];

  toggleAddressAutocomplete() {
    this.movingStreet = addressAutocomplete(this.addressInputTarget);
    searchByCountry(this.movingStreet, ['FR', 'GB']);
    autoFill(this.movingStreet);
    this.addAddressInputTarget.classList.remove('d-none');
    this.addAddressInputTarget.classList.add('d-flex');
    this.addAddressButtonTarget.classList.add('d-none');
    this.addAddressButtonTarget.classList.remove('d-flex');
  }

  toggleInput(event) {
    event.target.style.setProperty('display', 'none', 'important')
    let inputs = this.inputTargets
    inputs.push(this.phoneTarget);
    inputs.push(this.birthCityTarget);
    inputs.forEach(input => {
      if (input.dataset.id === event.target.dataset.id) {
        input.removeAttribute('readonly');
        input.classList.remove('readonly');
        input.parentNode.classList.remove('readonly');
         input.parentNode.parentNode.classList.remove('readonly');
        if (input === this.phoneTarget) {
          phoneInput(this.phoneTarget);
          this.phoneTarget.value = document.getElementById('user_phone').value;
        } if (input === this.birthCityTarget) {
          this.birthCity = addressAutocomplete(this.birthCityTarget);
          searchByCity(this.birthCity);
        }
      }
    });
    event.target.nextElementSibling.classList.remove('d-none');
  }

}
