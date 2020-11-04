import { Controller } from "stimulus";
import { displayBillingAutocomplete } from '../packs/algolia';

export default class extends Controller {
  static targets = [ "billingAddressInput", "deliveryAddressInput" ]

  connect() {
    displayBillingAutocomplete(this.billingAddressInputTarget);
    displayBillingAutocomplete(this.deliveryAddressInputTarget);
  }
}
