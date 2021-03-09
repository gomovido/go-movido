import { Controller } from "stimulus";
import {addressAutocomplete, searchByCountry, searchByCity } from '../packs/algolia';
const places = require('places.js');


export default class extends Controller {
  static targets = ["searchInput"]

  connect() {
    const searchInput = addressAutocomplete(this.searchInputTarget);
    searchByCountry(searchInput, ['FR', 'GB'])
    searchByCity(searchInput);
    searchInput.on('change', (e) => {
      if (e.suggestion.countryCode === 'gb') {
        document.querySelector('#country').value = 'uk'
      } else if (e.suggestion.countryCode === 'fr') {
        document.querySelector('#country').value = 'fr'
      }
      document.querySelector('#city').value = e.suggestion.name
    });
  }
}
