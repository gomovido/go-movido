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
    this.checkboxAddressTarget.checked ? document.querySelector('.user_addresses_street').classList.add('d-none') : document.querySelector('.user_addresses_street').classList.remove('d-none');
    this.checkboxDateTarget.checked ? this.dateInputTarget.classList.add('d-none') : this.dateInputTarget.classList.remove('d-none');

  }

  toggleAddress() {
    document.querySelector('.user_addresses_street').classList.toggle('d-none');
    this.addressInputTarget.value = '';
  }

  toggleDate() {
    this.dateInputTarget.classList.toggle('d-none');
    this.dateInputTarget.value = '';
  }
}
