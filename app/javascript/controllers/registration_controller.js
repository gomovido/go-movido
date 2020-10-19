import { Controller } from "stimulus";
import datepicker from '../packs/datepicker';
import intlTelInput from 'intl-tel-input';



export default class extends Controller {
  static targets = [ "date", "phone" ]

  connect() {
    datepicker(this.dateTarget);
    intlTelInput(this.phoneTarget, {
      preferredCountries: ['fr']
    });
    this.phoneTarget.value = `+${document.querySelector('.iti__active').getAttribute('data-dial-code')}`;
    const countries = document.querySelectorAll('.iti__country');
    countries.forEach((country) => {
      country.addEventListener('click', () => {
        this.phoneTarget.value = `+${country.getAttribute('data-dial-code')}`;
      })
    })

  }
}
