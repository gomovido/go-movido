import { Controller } from "stimulus";
import { mapBoxAutocomplete } from '../packs/mapbox';

export default class extends Controller {
  static targets = ["geocoder", "addressInput", "noAddress"]

  connect() {
    this.addressInputTarget.value = ""
    const geocoder = mapBoxAutocomplete(this.geocoderTarget)
    document.querySelector('input.mapboxgl-ctrl-geocoder--input').classList.add('form-control', 'string', 'required')
    document.querySelector('input.mapboxgl-ctrl-geocoder--input').setAttribute('required', 'required')
    if (document.getElementById('payment-form')) {
      document.querySelector('input.mapboxgl-ctrl-geocoder--input').setAttribute('name', 'billing[address_mapbox]')
      document.querySelector('input.mapboxgl-ctrl-geocoder--input').id = 'billing_address_mapbox'
    }
    this.geocoderTarget.addEventListener('change', (e) => {
      const response = JSON.parse(geocoder.lastSelected)
      if (response) {
        this.addressInputTarget.value = response.place_name_en
      }
    })
  }

  manualAddress() {
    let address = document.getElementById('shipping_address');
    address.classList.toggle("d-none");
    address.value = "";
    address.type = "text";
    document.querySelector('.mapboxgl-ctrl').classList.toggle('d-none');
    document.querySelector('i.fa-chevron-down').classList.toggle("rotate-smouth")
  }

  cleanCountryCode(e) {
    if (e.keyCode !== 13) {
      this.addressInputTarget.value = "";
    }
  }
}
