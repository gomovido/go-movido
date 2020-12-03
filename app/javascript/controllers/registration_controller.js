import { Controller } from "stimulus";
import phoneInput from '../packs/phone-input';
import {addressAutocomplete, searchByCountry, autoFill, searchByCity } from '../packs/algolia';
const places = require('places.js');

export default class extends Controller {
  static targets = ["streetInput", "streetWrapper", "countryWrapper", "textSwitch",  "phone", "cityInput"]

  connect() {
    if (document.getElementById('address_street')) {
      const addressInput = addressAutocomplete(this.streetInputTarget);
      searchByCountry(addressInput, ['FR', 'GB'])
      autoFill(addressInput);
    } else if (this.phoneTarget && this.cityInputTarget) {
      phoneInput(this.phoneTarget);
      this.birthCity = addressAutocomplete(this.cityInputTarget);
      searchByCity(this.birthCity);
    }

  }

  toggleInput() {
    this.streetInputTarget.value = null;
    this.countryWrapperTarget.value = null;
    this.streetWrapperTarget.classList.toggle('d-none');
    this.countryWrapperTarget.classList.toggle('d-none');
    if (this.streetWrapperTarget.classList.contains('d-none')) {
      this.textSwitchTarget.innerText = 'I have a moving address';
    } else {
      this.textSwitchTarget.innerText = "I don't have an address yet";
    }
  }
}
