import { Controller } from "stimulus";
import phoneInput from '../packs/phone-input';
import {addressAutocomplete, searchByCountry, autoFill, searchByCity } from '../packs/algolia';
const places = require('places.js');

export default class extends Controller {
  static targets = ["addressInput", "checkboxAddress", "streetInput", "countryInput", "form", "phone", "cityInput"]

  connect() {
    if (document.getElementById('address_street')) {
      const addressInput = addressAutocomplete(this.addressInputTarget);
      searchByCountry(addressInput, ['FR', 'GB'])
      autoFill(addressInput);
    } else if (this.phoneTarget && this.cityInputTarget) {
      phoneInput(this.phoneTarget);
      this.birthCity = addressAutocomplete(this.cityInputTarget);
      searchByCity(this.birthCity);
    }

  }

  toggleInput() {
    this.formTarget.reset();
    this.streetInputTarget.classList.toggle('d-none');
    this.countryInputTarget.classList.toggle('d-none');
  }

}
