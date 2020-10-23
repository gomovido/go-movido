import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ "firstStep", "secondStep", "addressForm"]


  toggleAddressForm(event) {
    console.log('hello')
    this.addressFormTarget.classList.toggle('d-none');
  }


  nextStep(event) {
    setTimeout(() => {
      this.firstStepTarget.classList.add('d-none');
      this.secondStepTarget.classList.remove('d-none');
    }, 50);
  }
}
