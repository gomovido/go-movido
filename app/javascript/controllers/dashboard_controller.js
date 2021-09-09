import { Controller } from "stimulus";
import StimulusReflex from "stimulus_reflex";

const stripeUrl = "https://api.stripe.com/v1/";
const secretKey = process.env.STRIPE_SECRET_KEY

export default class extends Controller {
  static targets = [ "card", "container"]

  connect() {

    StimulusReflex.register(this);
    const cached = document.documentElement.hasAttribute("data-turbolinks-preview")
    if (this.containerTarget.dataset.stripeId && !cached) {
      this.fetchCustomerSubscriptions(stripeUrl, secretKey, this.containerTarget.dataset.stripeId)
      .then(response => {
        this.stimulate("DashboardReflex#subscriptions",  response)
      })
    }
  }

  async fetchCustomerSubscriptions(stripeUrl, secretKey, stripeId) {
    let subscription;
    const apiKey = "Bearer " + secretKey
    try {
      subscription = await fetch((stripeUrl + "invoices?customer=" + stripeId + "&expand[]=data.subscription"), {
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

  openModal(e) {
    Array.prototype.forEach.call(document.getElementsByClassName('card-service'), function(e) {
      e.classList.remove('active')
      e.classList.add('small')
    });
    Array.prototype.forEach.call(document.getElementsByClassName('description'), function(e) {
      e.classList.add('d-none')
    });
    e.currentTarget.classList.toggle('active')
    document.getElementById('dialog').classList.add('active')
    this.stimulate("DashboardReflex#add_service_modal",  e.currentTarget.dataset.id)
  }

}
