import { Controller } from "stimulus";
import StimulusReflex from 'stimulus_reflex';
import numeral from 'numeral'

export default class extends Controller {

  static targets = ["price"]

  connect() {
    StimulusReflex.register(this);

  }


  updatePrice(e) {
    let OldPrice = parseInt(this.priceTarget.dataset.value, 10);
    let price = parseInt(e.currentTarget.dataset.price, 10)
    let newPrice = 0
    if (e.target.checked == true) {
      newPrice = OldPrice += price
    } else {
      newPrice = OldPrice -= price
    }
    this.priceTarget.dataset.value = newPrice
    this.priceTarget.innerHTML = numeral(newPrice / 100).format('0.00');
  }
}
