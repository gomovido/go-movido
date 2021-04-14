import { Controller } from "stimulus";
import { mapBoxAutocomplete } from '../packs/mapbox';

export default class extends Controller {
  static targets = ["geocoder", "country"]
  static values = { locale: String }

  connect() {
    const geocoder = mapBoxAutocomplete(this.geocoderTarget, this.localeValue)
    this.geocoderTarget.querySelector('input').setAttribute("name", "flat_preference[location]")
    this.geocoderTarget.addEventListener('change', (e) => {
      const response = JSON.parse(geocoder.lastSelected)
      if (response) {
        const suggestions = response.context
        const filtered = suggestions.find(key => key['id'].includes('country'))
        this.countryTarget.value = filtered['short_code']
      }

    })
  }
}
