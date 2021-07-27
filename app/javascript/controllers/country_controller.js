import { Controller } from "stimulus";
import { mapBoxRestrictedAutocomplete } from '../packs/mapbox';

export default class extends Controller {
  static targets = ["geocoder", "addressInput", "countryInput"]

  connect() {
    this.addressInputTarget.value = ""
    this.countryInputTarget.value = ""
    const geocoder = mapBoxRestrictedAutocomplete(this.geocoderTarget)
    document.querySelector('input.mapboxgl-ctrl-geocoder--input').classList.add('form-control', 'string', 'required')
    document.querySelector('input.mapboxgl-ctrl-geocoder--input').setAttribute('required', 'required')
    if (document.getElementById('payment-form')) {
      document.querySelector('input.mapboxgl-ctrl-geocoder--input').setAttribute('name', 'billing[address_mapbox]')
      document.querySelector('input.mapboxgl-ctrl-geocoder--input').id = 'billing_address_mapbox'
    }
    this.geocoderTarget.addEventListener('change', (e) => {
      const response = JSON.parse(geocoder.lastSelected)
      if (response) {
        let country = response.context.filter(c => c.id.includes('country'))[0]
        if (country) {
          this.countryInputTarget.value = country.short_code
        }
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
