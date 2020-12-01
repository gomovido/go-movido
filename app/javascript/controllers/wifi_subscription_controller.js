import { Controller } from "stimulus";
import { addressAutocomplete, searchByCountry } from '../packs/algolia';

export default class extends Controller {
  static targets = [ "delivery"]

  connect() {
    this.delivery = addressAutocomplete(this.deliveryTarget);
    this.deliveryTarget.dataset.country == 'France' ? searchByCountry(this.delivery, ['FR']) : searchByCountry(this.delivery, ['GB'])
   }
}
