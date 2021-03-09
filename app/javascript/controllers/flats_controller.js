import { Controller } from "stimulus";
import {addressAutocomplete, searchByCountry, searchByCity } from '../packs/algolia';
const places = require('places.js');


export default class extends Controller {
  static targets = ["searchInput"]

  connect() {
    const searchInput = addressAutocomplete(this.searchInputTarget);
    searchInput.configure({language: 'fr'})
    searchByCountry(searchInput, ['FR', 'GB'])
    searchByCity(searchInput);
    searchInput.on('change', (e) => {
      document.querySelector('#city').value = e.suggestion.name
      document.querySelector('#country').value = e.suggestion.countryCode
    });
  }
}
