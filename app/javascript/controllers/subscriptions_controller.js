import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ "firstStep", "secondStep", "addressForm", "billingForm", "topPart"]

  connect() {
    if (window.location.search.split('=').includes('?errorForm')) {
      this.topPartTarget.classList.remove('d-flex');
      this.topPartTarget.classList.add('d-none');
      this.billingFormTarget.classList.remove('d-none');
    }
  }


  toggleAddressForm(event) {
    this.addressFormTarget.classList.toggle('d-none');
  }

  toggleBillingForm() {
    this.topPartTarget.classList.remove('d-flex');
    this.topPartTarget.classList.add('d-none');
    this.billingFormTarget.classList.toggle('d-none');
  }


  nextStep(event) {
    setTimeout(() => {
      this.firstStepTarget.classList.add('d-none');
      this.secondStepTarget.classList.remove('d-none');
    }, 50);
  }
}
