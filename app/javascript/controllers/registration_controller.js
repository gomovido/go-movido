import { Controller } from "stimulus";
import phoneInput from '../packs/phone-input';
import {addressAutocomplete, searchByCountry, autoFill } from '../packs/algolia';
const places = require('places.js');

export default class extends Controller {
  static targets = ["addressInput", "checkboxAddress", "streetInput", "countryInput", "form"]

  connect() {
    const addressInput = addressAutocomplete(this.addressInputTarget);
    searchByCountry(addressInput, ['FR', 'GB'])
    autoFill(addressInput);
  }

  toggleInput() {
    this.formTarget.reset();
    this.streetInputTarget.classList.toggle('d-none');
    this.countryInputTarget.classList.toggle('d-none');
  }

}
