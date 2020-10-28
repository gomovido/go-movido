import { Controller } from "stimulus";
import phoneInput from '../packs/phone-input';
import displayAddressAutocomplete from '../packs/algolia';


export default class extends Controller {
  static targets = [ "date", "phone", "dateInput", "addressInput", "checkboxAddress", "checkboxDate" ]

  connect() {
    phoneInput(this.phoneTarget);
    displayAddressAutocomplete(this.addressInputTarget);
    this.phoneTarget.value = this.phoneTarget.getAttribute("value");
    this.addressInputTarget.value = this.addressInputTarget.getAttribute("value");
    this.checkboxAddressTarget.checked ? this.addressInputTarget.classList.add('d-none') : this.addressInputTarget.classList.remove('d-none');
    this.checkboxDateTarget.checked ? this.dateInputTarget.classList.add('d-none') : this.dateInputTarget.classList.remove('d-none');

  }

  toggleAddress() {
    this.addressInputTarget.classList.toggle('d-none');
  }

  toggleDate() {
    this.dateInputTarget.classList.toggle('d-none');
  }
}
