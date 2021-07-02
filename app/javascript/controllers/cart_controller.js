import { Controller } from "stimulus";
import numeral from 'numeral';
import { CountUp } from 'countup.js';


export default class extends Controller {

  static targets = ["price"]

  updatePrice(e) {
    if (document.querySelector('.carts-new-container')) {
      const productNode = e.currentTarget.parentNode.parentNode
      const icon = productNode.querySelector('#check')
      productNode.classList.toggle('active');
      if (icon.classList.contains('fa-plus')) {
        icon.classList.remove('fa-plus')
        icon.classList.add('fa-check')
      } else {
        icon.classList.remove('fa-check')
        icon.classList.add('fa-plus')
      }
    }
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
      "duration": 0.3
    };
    const countUp = new CountUp(this.priceTarget, numeral(newPrice / 100).format('0.00'), options);
    countUp.start();
  }

}
