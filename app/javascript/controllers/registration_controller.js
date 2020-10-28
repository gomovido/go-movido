import { Controller } from "stimulus";
import phoneInput from '../packs/phone-input';
import displayAddressAutocomplete from '../packs/algolia';


export default class extends Controller {
  static targets = [ "date", "phone", "dateInput", "addressInput" ]

  connect() {
    phoneInput(this.phoneTarget);
    displayAddressAutocomplete(this.addressInputTarget);
  }

  toggleAddress() {
    this.addressInputTarget.classList.toggle('d-none');
  }

  toggleDate() {
    this.dateInputTarget.classList.toggle('d-none');
  }
}
