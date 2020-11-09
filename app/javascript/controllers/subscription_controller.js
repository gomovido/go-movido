import { Controller } from "stimulus";
import { displayBillingAutocomplete } from '../packs/algolia';

export default class extends Controller {
  static targets = [ "billingAddressInput", "deliveryAddressInput", "firstPart", "secondPart" ]

  connect() {
    displayBillingAutocomplete(this.billingAddressInputTarget);
    displayBillingAutocomplete(this.deliveryAddressInputTarget);
  }

  stepForward() {
    window.scroll({top: 0});
    this.firstPartTarget.classList.add('d-none');
    this.secondPartTarget.classList.remove('d-none');
    document.querySelector('.step-title').innerText = 'Please choose your SIM Card format';
  }

  stepBackward() {
    window.scroll({top: 0});
    this.firstPartTarget.classList.remove('d-none');
    this.secondPartTarget.classList.add('d-none');
    document.querySelector('.step-title').innerText = 'Please complete your payment details';
  }
}
