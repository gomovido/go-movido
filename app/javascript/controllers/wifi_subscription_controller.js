import { Controller } from "stimulus";
import { addressAutocomplete, searchByCountry } from '../packs/algolia';
import phoneInput from '../packs/phone-input';

export default class extends Controller {
  static targets = [ "delivery", "phone"]

  connect() {
    phoneInput(this.phoneTarget);
    this.delivery = addressAutocomplete(this.deliveryTarget);
    this.delivery.on('change', e => {
      document.querySelector('#algolia_country_code').value = e.suggestion.countryCode
    });
    searchByCountry(this.delivery, [this.deliveryTarget.dataset.country.toUpperCase()])
   }

  cleanCountryCode() {
    document.querySelector('#algolia_country_code').value = "";
  }
}
