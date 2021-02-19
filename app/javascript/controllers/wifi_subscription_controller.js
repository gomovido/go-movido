import { Controller } from "stimulus";
import { addressAutocomplete, searchByCountry } from '../packs/algolia';

export default class extends Controller {
  static targets = [ "delivery"]

  connect() {
    this.delivery = addressAutocomplete(this.deliveryTarget);
    searchByCountry(this.delivery, [this.deliveryTarget.dataset.country.toUpperCase()])
   }
}
