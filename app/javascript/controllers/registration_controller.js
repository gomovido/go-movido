import { Controller } from "stimulus";
import phoneInput from '../packs/phone-input';
import Flatpickr from "stimulus-flatpickr";
import "flatpickr/dist/themes/dark.css";



export default class extends Controller {
  static targets = [ "date", "phone", "dateInput", "addressInput" ]

  connect() {
    phoneInput(this.phoneTarget);
  }

  toggleAddress() {
    this.addressInputTarget.classList.toggle('d-none');
  }

  toggleDate() {
    this.dateInputTarget.classList.toggle('d-none');
  }
}
