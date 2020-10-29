import { Controller } from "stimulus";
const places = require('places.js');

export default class extends Controller {
  static targets = [ "addressForm", "addressSummary", "addressInput"]

  connect() {
    const placesAutocomplete = places({
      appId: 'pl32PKK41FYV',
      apiKey: '40d7e2e6a30185453dfe6ae9ba07433f',
      container: this.addressInputTarget
    });
  }


  toggleAddressForm(event) {
    this.addressSummaryTarget.classList.remove('d-flex');
    this.addressSummaryTarget.classList.add('d-none');
    this.addressFormTarget.classList.toggle('d-none');
  }
}
