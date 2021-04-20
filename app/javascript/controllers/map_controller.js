import { Controller } from "stimulus";
import { mapboxMap } from '../packs/mapbox';

export default class extends Controller {
  static targets = ["mapContainer"]
  static values = { markers: Array, center: Array }

  connect() {
    this.map = mapboxMap(this.mapContainerTarget.id, this.markersValue, this.centerValue)
    console.log(this.map)
    Array.from(document.querySelectorAll('.flat-card-large')).forEach(card => {
      card.addEventListener('click', e => {
        let marker = document.getElementById(`marker-${card.id}`)
        marker.click();
        this.map.flyTo({center: [marker.dataset.lng, marker.dataset.lat], speed: 0.6})
      });
    })
  }
}
