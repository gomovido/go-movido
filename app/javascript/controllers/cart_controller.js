import { Controller } from "stimulus";
import numeral from 'numeral';
import { CountUp } from 'countup.js';


export default class extends Controller {

  static targets = ["price"]

  updatePrice(e) {
    let oldPrice = parseInt(this.priceTarget.dataset.value, 10);
    let startValCountUp = numeral(oldPrice / 100).format('0.00')
    let price = parseInt(e.currentTarget.dataset.price, 10)
    let newPrice = 0
    newPrice = e.target.checked == true ? oldPrice += price : oldPrice -= price
    this.priceTarget.dataset.value = newPrice
    var options = {
      "decimalPlaces": 2,
      "startVal": startValCountUp,
      "useGrouping": false,
    };
    const countUp = new CountUp(this.priceTarget, numeral(newPrice / 100).format('0.00'), options);
    countUp.start();
  }

  updateCountry(e) {
    document.querySelectorAll('.checkboxes-banner').forEach((el) => {
      // Do stuff here
      el.classList.toggle('d-none')
    });
  }

}
