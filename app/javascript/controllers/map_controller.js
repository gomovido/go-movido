import { Controller } from "stimulus";
import { mapboxMap, setMarkers } from '../packs/mapbox';

export default class extends Controller {

  connect() {
    let markers = JSON.parse(document.getElementById('map').dataset.markers)
    let center = JSON.parse(document.getElementById('map').dataset.center)
    this.map = mapboxMap('map', markers, center)
  }

  reloadMap() {
    this.map.remove()
    this.connect()
  }

  updateMarkers() {
    setMarkers(JSON.parse(document.getElementById('map').dataset.markers), this.map)
  }

  moveMap(event) {
    const marker = document.getElementById(`marker-${event.currentTarget.id}`)
    this.map.flyTo({center: [marker.dataset.lng, marker.dataset.lat], speed: 0.6})
    marker.click();
  }
}

