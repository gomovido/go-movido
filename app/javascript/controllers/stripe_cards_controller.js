import { Controller } from "stimulus";
import numeral from "numeral";
import { Stripe } from "stripe";
import StimulusReflex from "stimulus_reflex";

export default class extends Controller {
  static targets = [ "container"]


  connect() {
    StimulusReflex.register(this);
    var stripeUrl = "https://api.stripe.com/v1/";
    var secretKey = process.env.STRIPE_SECRET_KEY
    if (this.containerTarget.dataset.stripeId) {
      this.fetchStripeCards(stripeUrl, secretKey, this.containerTarget.dataset.stripeId)
      .then(response => {
          this.stimulate("DashboardReflex#payment_details",  response)
        })
    }
  }

  setCardToDefault(element) {
    var radio = document.getElementById(element.currentTarget.dataset.source)
    if (radio.checked) {
      radio.checked = false }
    else {
      Array.prototype.forEach.call(document.getElementsByClassName('radio'), function(el) {
        el.checked = false
      });
      radio.checked = true
    }
  }

  async fetchStripeCards(stripeUrl, secretKey, stripeId) {
    let invoice;
    const apiKey = "Bearer " + secretKey
    try {
      invoice = await fetch((stripeUrl + "customers/" + stripeId + "?expand[]=sources"), {
        method: "get",
        headers: {
          Accept: "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
          Authorization: apiKey,
        },
      });
      return await invoice.json()
    }
    catch (error) {
      return error
    }
  }

  togglePurpleBar() {
    const purpleBar = this.purpleTarget;
    if (this.starterTarget.classList.contains("active") && !this.settleInTarget.classList.contains("active")) {
      purpleBar.classList.add("active");
    } else {
      purpleBar.classList.remove("active");
    };
  };

}
