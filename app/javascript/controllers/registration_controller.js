import { Controller } from "stimulus";
import phoneInput from '../packs/phone-input';
import {addressAutocomplete, autoFill, searchByCity, searchByCountry} from '../packs/algolia';
const places = require('places.js');

export default class extends Controller {
  static targets = [ "date", "phone", "dateInput", "addressInput", "checkboxAddress", "checkboxDate", "cityInput", "cityMoving", "countryMoving" ]

  connect() {
    phoneInput(this.phoneTarget);
    this.movingAddress = addressAutocomplete(this.addressInputTarget);
    autoFill(this.movingAddress);
    this.birthCity = addressAutocomplete(this.cityInputTarget);
    searchByCity(this.birthCity);
    this.movingCity = addressAutocomplete(this.cityMovingTarget);
    searchByCity(this.movingCity);
    this.checkboxAddressTarget.checked ? document.querySelector('#addressInput').classList.add('d-none') : document.querySelector('#addressInput').classList.remove('d-none');

  }

  toggleAddress() {
    document.querySelector('#addressInput').classList.toggle('d-none');
    this.addressInputTarget.value = '';
  }

  updateAlgolia() {
    this.cityMovingTarget.value = '';
    this.addressInputTarget.value = '';
    let country = this.countryMovingTarget.value === 'France' ? 'FR' : 'GB';
    searchByCountry(this.movingCity, country);
    searchByCountry(this.movingAddress, country);
  }
}
