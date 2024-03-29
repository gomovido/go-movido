import { Controller } from "stimulus";
import numeral from "numeral";
import StimulusReflex from "stimulus_reflex";

const stripeUrl = "https://api.stripe.com/v1/";
const secretKey = process.env.STRIPE_SECRET_KEY

export default class extends Controller {
  static targets = [ "container"]

  connect() {
    StimulusReflex.register(this);
    const cached = document.documentElement.hasAttribute("data-turbolinks-preview")
    if (this.containerTarget.dataset.stripeId && !cached) {
      this.fetchStripeCustomer(stripeUrl, secretKey, this.containerTarget.dataset.stripeId)
      .then(response => {
        this.stimulate("DashboardReflex#payment_details",  response)
      })
    }
  }

  setCardToDefault(element) {
    this.updateCustomerSource(stripeUrl, secretKey, this.containerTarget.dataset.stripeId, element.currentTarget.dataset.source)
    .then(response => {
      this.updateRadioButton(document.getElementById(`${response.default_source}_`), document.getElementsByClassName('radio'))
    })
  }

  async updateCustomerSource(stripeUrl, secretKey, stripeId, sourceId) {
    let customer;
    const params = {'default_source': sourceId}
    const apiKey = "Bearer " + secretKey
    try {
      customer = await fetch((stripeUrl + "customers/" + stripeId), {
        method: "post",
        headers: {
          Accept: "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
          Authorization: apiKey,
        },
        body: Object.keys(params).map(key => key + '=' + params[key]).join('&')
      });
      return await customer.json()
    }
    catch (error) {
      return error
    }
  }

  updateRadioButton(element, radioInputs) {
    if (element.checked) {
      element.checked = false
    } else {
      Array.prototype.forEach.call(radioInputs, function(radio) { radio.checked = false });
      element.checked = true
    }
  }

  async fetchStripeCustomer(stripeUrl, secretKey, stripeId) {
    let customer;
    const apiKey = "Bearer " + secretKey
    try {
      customer = await fetch((stripeUrl + "customers/" + stripeId + "?expand[]=sources"), {
        method: "get",
        headers: {
          Accept: "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
          Authorization: apiKey,
        },
      });
      return await customer.json()
    }
    catch (error) {
      return error
    }
  }

}
