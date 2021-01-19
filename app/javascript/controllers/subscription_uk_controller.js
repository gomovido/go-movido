import { Controller } from "stimulus";
import { addressAutocomplete } from '../packs/algolia';

export default class extends Controller {

  static targets = [ 'billingAddressInput', 'deliveryAddressInput']
  connect() {
    addressAutocomplete(this.billingAddressInputTarget);
    if (document.querySelector('#billing_subscription_attributes_delivery_address')) {
      addressAutocomplete(this.deliveryAddressInputTarget);
    }
  }
}
