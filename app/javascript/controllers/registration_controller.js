import { Controller } from "stimulus";
import phoneInput from '../packs/phone-input';
import displayAddressAutocomplete, { displayBirthCityAutocomplete, displayCityMovingAutocomplete } from '../packs/algolia';
const places = require('places.js');

export default class extends Controller {
  static targets = [ "date", "phone", "dateInput", "addressInput", "checkboxAddress", "checkboxDate", "cityInput", "cityMoving", "countryMoving" ]

  connect() {
    phoneInput(this.phoneTarget);
    displayAddressAutocomplete(this.addressInputTarget);
    displayBirthCityAutocomplete(this.cityInputTarget);
    this.placeInstance = displayBirthCityAutocomplete(this.cityMovingTarget);
    this.checkboxAddressTarget.checked ? document.querySelector('#addressInput').classList.add('d-none') : document.querySelector('#addressInput').classList.remove('d-none');

  }

  toggleAddress() {
    document.querySelector('#addressInput').classList.toggle('d-none');
    this.addressInputTarget.value = '';
  }

  updateAlgolia() {
    this.cityMovingTarget.value = '';
    let country = this.countryMovingTarget.value === 'France' ? 'FR' : 'GB';
    displayCityMovingAutocomplete(this.placeInstance, country);
  }
}
