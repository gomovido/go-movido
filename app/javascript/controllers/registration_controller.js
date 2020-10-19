import { Controller } from "stimulus";
import datepicker from '../packs/datepicker';
import intlTelInput from 'intl-tel-input';



export default class extends Controller {
  static targets = [ "date", "phone" ]

  connect() {
    datepicker(this.dateTarget);
    intlTelInput(this.phoneTarget, {});
  }
}
