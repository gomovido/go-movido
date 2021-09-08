import { Controller } from "stimulus";
import numeral from "numeral";
import StimulusReflex from "stimulus_reflex";

const stripeUrl = "https://api.stripe.com/v1/";
const secretKey = process.env.STRIPE_SECRET_KEY

export default class extends Controller {
  static targets = [ "container", "subscriptionTotalPrice"]

  connect() {
    StimulusReflex.register(this);
    if (this.containerTarget.dataset.stripeId) {
      this.fetchCustomerSubscriptions(stripeUrl, secretKey, this.containerTarget.dataset.stripeId)
      .then(response => {
        console.log(response)
        this.stimulate("DashboardReflex#subscriptions",  response)
      })
    }
  }


  async fetchCustomerNextDueInvoice(stripeUrl, secretKey, stripeId) {
    let invoice;
    const apiKey = "Bearer " + secretKey
    try {
      invoice = await fetch((stripeUrl + "invoices/upcoming?customer=" + stripeId), {
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



  async fetchCustomerSubscriptions(stripeUrl, secretKey, stripeId) {
    let subscription;
    const apiKey = "Bearer " + secretKey
    try {
      subscription = await fetch((stripeUrl + "invoices?customer=" + stripeId), {
        method: "get",
        headers: {
          Accept: "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
          Authorization: apiKey,
        },
      });
      return await subscription.json()
    }
    catch (error) {
      return error
    }
  }

}
