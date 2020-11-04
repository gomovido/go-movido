import { Controller } from "stimulus";
import { displayBillingAutocomplete } from '../packs/algolia';

export default class extends Controller {
  static targets = [ "addressInput" ]

  connect() {
    displayBillingAutocomplete(this.addressInputTarget);
  }
}
