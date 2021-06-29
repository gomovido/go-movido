import { Controller } from "stimulus";
import numeral from 'numeral';
import { CountUp } from 'countup.js';


export default class extends Controller {

  updateCountry(e) {
    document.querySelectorAll('.checkboxes-banner').forEach((el) => {
      // Do stuff here
      el.classList.toggle('d-none')
    });
  }

}
