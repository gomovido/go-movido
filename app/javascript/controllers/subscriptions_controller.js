import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ "firstStep", "secondStep", "addressForm", "billingForm", "billingSummary", "addressSummary"]

  connect() {
    if (window.location.search.split('=').includes('?errorForm')) {
      this.billingSummaryTarget.classList.remove('d-flex');
      this.billingSummaryTarget.classList.add('d-none');
      this.billingFormTarget.classList.remove('d-none');
    }
  }


  toggleAddressForm(event) {
    this.addressSummaryTarget.classList.remove('d-flex');
    this.addressSummaryTarget.classList.add('d-none');
    this.addressFormTarget.classList.toggle('d-none');
  }

  toggleBillingForm() {
    this.billingSummaryTarget.classList.remove('d-flex');
    this.billingSummaryTarget.classList.add('d-none');
    this.billingFormTarget.classList.toggle('d-none');
  }


  nextStep(event) {
    setTimeout(() => {
      this.firstStepTarget.classList.remove('d-flex');
      this.firstStepTarget.classList.add('d-none');
      this.secondStepTarget.classList.remove('d-none');
      this.secondStepTarget.classList.add('d-flex');
    }, 50);
  }
}
