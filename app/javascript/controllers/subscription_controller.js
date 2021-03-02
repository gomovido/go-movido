import { Controller } from "stimulus";
import { addressAutocomplete } from '../packs/algolia';

export default class extends Controller {
  static targets = [ "continueButton", "billingAddressInput", "firstPart", "secondPart", "ibanInput", "giffgaffAddressInput" ]
  static classes = [ "hide", "disabled" ]
  static values = { locale: String }
  connect() {
    let deliveryField = document.getElementById('billing_subscription_attributes_delivery_address')
    let billingAddress = addressAutocomplete(this.billingAddressInputTarget);
    if (deliveryField && deliveryField.dataset.company === "giffgaff") {
      addressAutocomplete(deliveryField);
    } else if (deliveryField) {
      this.enableButton();
      billingAddress.on('change', (e) => {
        deliveryField.value = e.suggestion.value;
        this.enableButton();
      });
    }
    billingAddress.on('change', e =>{
      document.querySelector('#algolia_country_code').value = e.suggestion.countryCode
    });
  }

  cleanCountryCode() {
    document.querySelector('#algolia_country_code').value = ""
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
