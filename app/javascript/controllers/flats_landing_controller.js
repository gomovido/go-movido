import { Controller } from "stimulus";
import { mapBoxAutocomplete } from '../packs/mapbox';

export default class extends Controller {
  static targets = ["geocoder", "coordinates"]
  static values = { locale: String }

  connect() {
    const geocoder = mapBoxAutocomplete(this.geocoderTarget, this.localeValue)
    this.geocoderTarget.addEventListener('change', (e) => {
      const response = JSON.parse(geocoder.lastSelected)
      if (response) {
        this.coordinatesTarget.value = [response['geometry']['coordinates'][1], response['geometry']['coordinates'][0]]
      }
    })
  }
}
