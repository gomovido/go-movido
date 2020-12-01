import ApplicationController from './application_controller'
import phoneInput from '../packs/phone-input';
import {addressAutocomplete, searchByCity, searchByCountry, autoFill} from '../packs/algolia';
const places = require('places.js');

export default class extends ApplicationController {
  static targets = ['phone', 'submit', 'input', 'addressInput', 'addAddressInput', 'addAddressButton', 'cityInput']

  toggleAddressAutocomplete() {
    this.addAddressInputTarget.classList.remove('d-none');
    this.addAddressInputTarget.classList.add('d-flex');
    this.addAddressButtonTarget.classList.add('d-none');
    this.addAddressButtonTarget.classList.remove('d-flex');
    this.movingStreet = addressAutocomplete(this.addressInputTarget);
    searchByCountry(this.movingStreet, ['FR', 'GB']);
    autoFill(this.movingStreet);
  }

  toggleInput(event) {
    this.birthCity = addressAutocomplete(this.cityInputTarget);
    searchByCity(this.birthCity);
    const activeElement = document.getElementsByClassName('active')[0]
    const input = this.inputTargets.find(input => input.id == event.target.dataset.id)
    if (event.target.dataset.id === 'phone') {
      phoneInput(this.phoneTarget);
      this.phoneTarget.value = document.getElementById('user_phone').dataset.value
    }
    if (activeElement && activeElement != input) {
      activeElement.classList.add('d-none')
      activeElement.classList.remove('active')
    }
    input.classList.toggle('d-none');
    input.classList.toggle('active');
  }

  togglePen(event) {
    $(".fa-pen").each(function() {
        $(this).addClass("d-none");
    });
    document.getElementsByClassName('fa-pen')[event.target.getAttribute('data-id')].classList.remove('d-none')
  }

}
