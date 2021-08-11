import { Controller } from "stimulus";
import numeral from "numeral";
import StimulusReflex from "stimulus_reflex";
import { CountUp } from "countup.js";

export default class extends Controller {
  static targets = ["subscriptionPrice", "activationPrice"];

  updatePrice(e) {
    this.animateCard(e);
    if (e.currentTarget.dataset.subscriptionPrice) {
      this.calculate(
        e,
        e.currentTarget.dataset.subscriptionPrice,
        this.subscriptionPriceTarget
      );
    }
    if (e.currentTarget.dataset.activationPrice) {
      this.calculate(
        e,
        e.currentTarget.dataset.activationPrice,
        this.activationPriceTarget
      );
    }
  }

  animateCard(e) {
    if (document.querySelector(".carts-new-container")) {
      const productNode = e.currentTarget.parentNode.parentNode;
      const icon = productNode.querySelector("#check");
      productNode.classList.toggle("active");
      if (icon.classList.contains("fa-plus")) {
        icon.classList.remove("fa-plus");
        icon.classList.add("fa-check");
      } else {
        icon.classList.remove("fa-check");
        icon.classList.add("fa-plus");
      }
    }
  }

  calculate(event, price, target) {
    let oldPrice = parseInt(target.dataset.value, 10);
    let startValCountUp = numeral(oldPrice / 100).format("0.00");
    var price = parseInt(price, 10);
    let newPrice = 0;
    newPrice =
      event.target.checked == true ? (oldPrice += price) : (oldPrice -= price);
    target.dataset.value = newPrice;
    var options = {
      decimalPlaces: 2,
      startVal: startValCountUp,
      useGrouping: false,
      duration: 0.3,
    };
    const countUp = new CountUp(
      target,
      numeral(newPrice / 100).format("0.00"),
      options
    );
    countUp.start();
  }
}
