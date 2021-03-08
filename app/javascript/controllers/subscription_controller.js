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

  cleanCountryCode(e) {
    if (e.keyCode !== 13) {
      document.querySelector('#algolia_country_code').value = "";
    }
  }

  stepForward() {
    if (this.localeValue === 'fr') {
      document.querySelector('.subtitle').innerText = "Sélectionne le format de ta carte SIM"
    } else {
      document.querySelector('.subtitle').innerText = "Please choose your SIM card size"
    }
    window.scroll({top: 0});
    this.firstPartTarget.classList.add(this.hideClass);
    this.secondPartTarget.classList.remove(this.hideClass);
  }

  stepBackward() {
    if (this.localeValue === 'fr') {
      document.querySelector('.subtitle').innerText = "Nous avons besoin de tes coordonnées bancaires pour l'option de prélèvement automatique de ton abonnement"
    } else {
      document.querySelector('.subtitle').innerText = "We need your bank details to set up the direct debit option of your subscription"
    }
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
