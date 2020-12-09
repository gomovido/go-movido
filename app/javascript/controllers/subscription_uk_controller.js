import { Controller } from "stimulus";
import { addressAutocomplete } from '../packs/algolia';

export default class extends Controller {

  static targets = [ 'billingAddressInput', 'deliveryAddressInput']
  connect() {
    addressAutocomplete(this.billingAddressInputTarget);
    addressAutocomplete(this.deliveryAddressInputTarget);
  }
}
