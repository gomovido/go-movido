import { Controller } from "stimulus";
import { addressAutocomplete } from '../packs/algolia';

export default class extends Controller {
  static targets = [ "continueButton", "billingAddressInput", "firstPart", "secondPart", "ibanInput", "giffgaffAddressInput" ]
  static classes = [ "hide", "disabled" ]
  static values = { locale: String }
  connect() {
    let deliveryField = document.getElementById('billing_subscription_attributes_delivery_address')
    if (deliveryField && deliveryField.dataset.company === "giffgaff") {
      addressAutocomplete(deliveryField);
      addressAutocomplete(this.billingAddressInputTarget);
    } else if (deliveryField) {
      this.enableButton();
      addressAutocomplete(this.billingAddressInputTarget).on('change', (e) => {
        deliveryField.value = e.suggestion.value;
        this.enableButton();
      });
    } else {
      addressAutocomplete(this.billingAddressInputTarget);
    }
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
    let deliveryField = document.getElementById('billing_subscription_attributes_delivery_address')
    if (document.getElementById('continueButton')) {
      if (deliveryField.value && this.ibanInputTarget.value) {
        this.continueButtonTarget.classList.remove(this.disabledClass);
      }
    }
  }
}
