import { Controller } from "stimulus";
import { mapboxMap } from '../packs/mapbox';

export default class extends Controller {
  static targets = ["mapContainer"]
  static values = { center: Array, coordinates: Array }

  connect() {
    mapboxMap(this.mapContainerTarget.id, this.centerValue[1], this.centerValue[0], this.coordinatesValue)
  }
}
