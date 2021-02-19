import { Controller } from "stimulus";
import {addressAutocomplete, autoFill, searchByCountry} from '../packs/algolia';
import StimulusReflex from 'stimulus_reflex';
const places = require('places.js');

export default class extends Controller {
  static targets = ["streetInput", "button"]
  static values = {country: String}

  connect() {
    StimulusReflex.register(this);
    const addressInput = addressAutocomplete(this.streetInputTarget);
    searchByCountry(addressInput, [this.countryValue])
    addressInput.on('change', (e) => {
      document.querySelector('#address_zipcode').value = e.suggestion.postcode
      document.querySelector('#address_city').value = e.suggestion.county
      document.querySelector('#algolia_country_code').value = e.suggestion.countryCode
      this.streetInputTarget.classList.remove('is-invalid')
      this.streetInputTarget.classList.add('is-valid')
      this.stimulate('AddressReflex#create_with_modal', this.streetInputTarget)
        .then(() => {
          this.buttonTarget.classList.remove('disabled');
        });
    });
  }


  borderColor() {
    if (document.querySelector('#address_zipcode').value === "" || document.querySelector('#address_city').value === "" || document.querySelector('#algolia_country_code').value === "" || this.streetInputTarget.value === "") {
      this.streetInputTarget.classList.remove('is-valid');
      this.streetInputTarget.classList.add('is-invalid');
    }
  }
}
