import { Controller } from "stimulus";
import { mapBoxAutocomplete } from '../packs/mapbox';

export default class extends Controller {
  static targets = ["geocoder"]

  connect() {
    mapBoxAutocomplete(this.geocoderTarget)
    this.geocoderTarget.querySelector('input').setAttribute("name", "location")
  }
}
