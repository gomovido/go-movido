import { Controller } from "stimulus";
import phoneInput from '../packs/phone-input';
import {addressAutocomplete, searchByCountry, autoFill, searchByCity } from '../packs/algolia';
const places = require('places.js');

export default class extends Controller {
  static targets = ["streetInput", "streetWrapper", "countryWrapper", "phone", "cityInput", "countryInput"]
  static classes = [ "hide" ]
  static values = { countries: String }

  connect() {
    if (document.getElementById('address_street')) {
      const addressInput = addressAutocomplete(this.streetInputTarget);
      searchByCountry(addressInput, JSON.parse(this.countriesValue))
      autoFill(addressInput);
    } else if (this.phoneTarget && this.cityInputTarget) {
      phoneInput(this.phoneTarget);
      this.birthCity = addressAutocomplete(this.cityInputTarget);
      searchByCity(this.birthCity);
    }

  }

  toggleInput() {
    this.streetInputTarget.value = null;
    this.countryInputTarget.selectedIndex = 0;;
    this.streetWrapperTarget.classList.toggle(this.hideClass);
    this.countryWrapperTarget.classList.toggle(this.hideClass);
  }
}
