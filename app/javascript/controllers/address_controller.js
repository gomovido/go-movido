import { Controller } from "stimulus";
import { mapBoxAutocomplete } from '../packs/mapbox';

export default class extends Controller {
  static targets = ["geocoder", "addressInput"]

  connect() {
    this.addressInputTarget.value = ""
    const geocoder = mapBoxAutocomplete(this.geocoderTarget)
    document.querySelector('input.mapboxgl-ctrl-geocoder--input').classList.add('form-control', 'string', 'required')
    document.querySelector('input.mapboxgl-ctrl-geocoder--input').setAttribute('required', 'required')
    this.geocoderTarget.addEventListener('change', (e) => {
      const response = JSON.parse(geocoder.lastSelected)
      if (response) {
        this.addressInputTarget.value = response.place_name_en
      }
    })
  }

  cleanCountryCode(e) {
    if (e.keyCode !== 13) {
      this.addressInputTarget.value = "";
    }
  }
}
