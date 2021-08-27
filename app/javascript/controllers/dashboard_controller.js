import { Controller } from "stimulus";
import numeral from "numeral";
import { Stripe } from "stripe";
import StimulusReflex from "stimulus_reflex";

export default class extends Controller {
  static targets = [ "purple", "starter", "settleIn", "subscriptionPrice", "subscriptionPaid"]


  connect() {
    StimulusReflex.register(this);
    var stripeUrl = "https://api.stripe.com/v1/";
    var secretKey = process.env.STRIPE_SECRET_KEY
    if (this.subscriptionPriceTarget.dataset.stripeId) {
      this.fetchStripeSubscription(stripeUrl, secretKey, this.subscriptionPriceTarget.dataset.stripeId)
      .then(response => {
          //this.stimulate("DashboardReflex#subscriptions",  response)
        })
    }
  }

  async fetchStripeSubscription(stripeUrl, secretKey, stripeId) {
    let invoice;
    const apiKey = "Bearer " + secretKey
    try {
      invoice = await fetch(stripeUrl + "subscriptions/" + stripeId, {
        method: "get",
        headers: {
          Accept: "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
          Authorization: apiKey,
        }
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
