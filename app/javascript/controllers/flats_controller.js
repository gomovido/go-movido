import { Controller } from "stimulus";
import { mapBoxAutocomplete } from '../packs/mapbox';

export default class extends Controller {
  static targets = ["geocoder"]
  static values = { locale: String }

  connect() {
    mapBoxAutocomplete(this.geocoderTarget, this.localeValue)
    this.geocoderTarget.querySelector('input').setAttribute("name", "location")
  }
}
