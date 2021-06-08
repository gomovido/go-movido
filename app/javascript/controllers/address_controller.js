import { Controller } from "stimulus";
import { mapBoxAutocomplete } from '../packs/mapbox';

export default class extends Controller {
  static targets = ["geocoder", "addressInput"]

  connect() {
    const geocoder = mapBoxAutocomplete(this.geocoderTarget)
    document.querySelector('input.mapboxgl-ctrl-geocoder--input').setAttribute('name', 'shipping[address_mapbox]')
    document.querySelector('input.mapboxgl-ctrl-geocoder--input').classList.add('form-control', 'string', 'required')
    document.querySelector('input.mapboxgl-ctrl-geocoder--input').setAttribute('required', 'required')
    document.querySelector('input.mapboxgl-ctrl-geocoder--input').id = 'shipping_address_mapbox'
    this.geocoderTarget.addEventListener('change', (e) => {
      const response = JSON.parse(geocoder.lastSelected)
      if (response) {
        console.log(response)
        this.addressInputTarget.value = response.place_name_en
        console.log(this.addressInputTarget)
      }
    })
  }

  cleanCountryCode(e) {
    if (e.keyCode !== 13) {
      this.addressInputTarget.value = "";
      console.log(this.addressInputTarget)
    }
  }
}
