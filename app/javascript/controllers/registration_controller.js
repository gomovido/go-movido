import { Controller } from "stimulus";
import phoneInput from '../packs/phone-input';
import displayAddressAutocomplete, { displayBirthCityAutocomplete } from '../packs/algolia';
const places = require('places.js');


export default class extends Controller {
  static targets = [ "date", "phone", "dateInput", "addressInput", "checkboxAddress", "checkboxDate", "cityInput" ]

  connect() {
    phoneInput(this.phoneTarget);
    displayAddressAutocomplete(this.addressInputTarget);
    displayBirthCityAutocomplete(this.cityInputTarget);
    this.checkboxAddressTarget.checked ? document.querySelector('.user_addresses_street').classList.add('d-none') : document.querySelector('.user_addresses_street').classList.remove('d-none');

  }

  toggleAddress() {
    document.querySelector('.user_addresses_street').classList.toggle('d-none');
    this.addressInputTarget.value = '';
  }
}
