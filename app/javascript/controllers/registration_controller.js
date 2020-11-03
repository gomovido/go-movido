import { Controller } from "stimulus";
import phoneInput from '../packs/phone-input';
import displayAddressAutocomplete from '../packs/algolia';


export default class extends Controller {
  static targets = [ "date", "phone", "dateInput", "addressInput", "checkboxAddress", "checkboxDate" ]

  connect() {
    phoneInput(this.phoneTarget);
    displayAddressAutocomplete(this.addressInputTarget);
    this.addressInputTarget.value = this.addressInputTarget.getAttribute("value");
    this.checkboxAddressTarget.checked ? document.querySelector('.user_addresses_street').classList.add('d-none') : document.querySelector('.user_addresses_street').classList.remove('d-none');

  }

  toggleAddress() {
    document.querySelector('.user_addresses_street').classList.toggle('d-none');
    this.addressInputTarget.value = '';
  }
}
