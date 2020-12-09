import { Controller } from "stimulus";
import { addressAutocomplete } from '../packs/algolia';
import iban_to_bank from '../packs/iban_to_bank'

export default class extends Controller {
  static targets = [ "continueButton", "bicInput", "billingAddressInput", "deliveryAddressInput", "firstPart", "secondPart", "bankInput", "ibanInput" ]
  connect() {
    addressAutocomplete(this.billingAddressInputTarget).on('change', (e) => {
      this.deliveryAddressInputTarget.value = e.suggestion.value;
      this.enableButton();
    });
    $('[data-toggle="tooltip"]').tooltip();
    this.bankInputTarget.value = iban_to_bank(this.ibanInputTarget.value);
  }

  stepForward() {
    window.scroll({top: 0});
    this.firstPartTarget.classList.add('d-none');
    this.secondPartTarget.classList.remove('d-none');
  }

  stepBackward() {
    window.scroll({top: 0});
    this.firstPartTarget.classList.remove('d-none');
    this.secondPartTarget.classList.add('d-none');
  }

  fillBank() {
    this.bankInputTarget.value = iban_to_bank(this.ibanInputTarget.value);
    this.enableButton();
  }

  enableButton() {
    if (document.getElementById('continueButton')) {
      if (this.bicInputTarget.value && this.deliveryAddressInputTarget.value && this.ibanInputTarget.value) {
        this.continueButtonTarget.classList.remove('disabled');
      }
    }
  }
}
