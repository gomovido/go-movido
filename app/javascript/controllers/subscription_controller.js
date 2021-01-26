import { Controller } from "stimulus";
import { addressAutocomplete } from '../packs/algolia';

export default class extends Controller {
  static targets = [ "continueButton", "billingAddressInput", "deliveryAddressInput", "firstPart", "secondPart", "ibanInput" ]
  static classes = [ "hide", "disabled" ]
  static values = { locale: String }
  connect() {
    addressAutocomplete(this.billingAddressInputTarget).on('change', (e) => {
      this.deliveryAddressInputTarget.value = e.suggestion.value;
      this.enableButton();
    });
  }

  stepForward() {
    window.scroll({top: 0});
    this.firstPartTarget.classList.add(this.hideClass);
    this.secondPartTarget.classList.remove(this.hideClass);
  }

  stepBackward() {
    window.scroll({top: 0});
    this.firstPartTarget.classList.remove(this.hideClass);
    this.secondPartTarget.classList.add(this.hideClass);
  }

  enableButton() {
    if (document.getElementById('continueButton')) {
      if (this.deliveryAddressInputTarget.value && this.ibanInputTarget.value) {
        this.continueButtonTarget.classList.remove(this.disabledClass);
      }
    }
  }
}
