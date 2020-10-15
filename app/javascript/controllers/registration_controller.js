import { Controller } from "stimulus";
import datepicker from '../packs/datepicker';

export default class extends Controller {
  static targets = [ "date" ]

  connect() {
    datepicker(this.dateTarget);
  }
}
