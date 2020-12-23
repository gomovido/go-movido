import ApplicationController from './application_controller'
import phoneInput from '../packs/phone-input';
import {addressAutocomplete, searchByCity, searchByCountry, autoFill} from '../packs/algolia';
const places = require('places.js');

export default class extends ApplicationController {
  static targets = ['phone', 'input', 'addressInput', 'addAddressInput', 'addAddressButton', 'birthCity'];
  static classes = [ 'hide', 'flex', 'readonly' ]

  updateNavbar(event) {
    if (event.target.value) {
      document.getElementById('navbarDropdown').innerText = document.getElementById('user_first_name').value + ' ' + document.getElementById('user_last_name').value;
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

  toggleInput(event) {
    event.target.style.setProperty('display', 'none', 'important')
    let inputs = this.inputTargets
    inputs.push(this.phoneTarget);
    inputs.push(this.birthCityTarget);
    inputs.forEach(input => {
      if (input.dataset.id === event.target.dataset.id) {
        input.removeAttribute('readonly');
        input.classList.remove(this.readonlyClass);
        input.parentNode.classList.remove(this.readonlyClass);
         input.parentNode.parentNode.classList.remove(this.readonlyClass);
        if (input === this.phoneTarget) {
          phoneInput(this.phoneTarget);
          this.phoneTarget.value = document.getElementById('user_phone').value;
        } if (input === this.birthCityTarget) {
          this.birthCity = addressAutocomplete(this.birthCityTarget);
          searchByCity(this.birthCity);
        }
      }
    });
    event.target.nextElementSibling.classList.remove(this.hideClass);
  }
}
