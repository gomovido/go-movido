import Flatpickr from "stimulus-flatpickr";

export default class extends Flatpickr {
  connect() {
    this.config = { locale: { rangeSeparator: ' - ' }};
    super.connect();
  }
}
