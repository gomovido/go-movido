import { Controller } from "stimulus";


export default class extends Controller {
  static targets = [ "addressInput" ]

  connect() {
    const places = require('places.js');
    var placesAutocomplete = places({
      appId: 'pl32PKK41FYV',
      apiKey: '40d7e2e6a30185453dfe6ae9ba07433f',
      container: this.addressInputTarget
    });
  }
}
