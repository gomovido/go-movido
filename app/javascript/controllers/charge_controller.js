import { Controller } from "stimulus";

export default class extends Controller {

  connect() {
    const stripe = Stripe(process.env.STRIPE_PUBLISHABLE_KEY);
    const elements = stripe.elements({locale: document.getElementById('payment-form').dataset.locale});

    const style = {
      base: {
        color: '#0D4D90',
        fontFamily: '"Lato", sans-serif',
        fontSmoothing: 'antialiased',
        fontSize: '16px',
        '::placeholder': {
          color: '#798CA0'
        }
      },
      invalid: {
        color: '#FD1015',
        iconColor: '#FD1015'
      }
    };
    const cardNumberElement = elements.create('cardNumber', {showIcon: true, style: style});
    cardNumberElement.mount('#card-number-element');
    const cardExpiryElement = elements.create('cardExpiry', {style: style});
    cardExpiryElement.mount('#card-expiry-element');
    const cardCvcElement = elements.create('cardCvc', {style: style});
    cardCvcElement.mount('#card-cvc-element');
    cardNumberElement.on('change', (event) => {
      const displayError = document.getElementById('card-errors');
      if (event.error) {
        displayError.textContent = event.error.message;
      } else {

        displayError.textContent = '';
      }
    });
    const form = document.getElementById('payment-form');
    form.addEventListener('submit',(event) => {
      document.getElementById('loader').style.height = `${document.body.scrollHeight}px`
      document.getElementById('loader').classList.remove('d-none');
      event.preventDefault();
      stripe.createToken(cardNumberElement).then((result) => {
        if (result.error) {
          document.getElementById('loader').classList.add('d-none');
          const errorElement = document.getElementById('card-errors');
          errorElement.textContent = result.error.message;
        } else {
          this.stripeTokenHandler(result.token);
        }
      });
    });
  }
  stripeTokenHandler(token) {
    const form = document.getElementById('payment-form');
    const hiddenInput = document.createElement('input');
    hiddenInput.setAttribute('type', 'hidden');
    hiddenInput.setAttribute('name', 'stripeToken');
    hiddenInput.setAttribute('value', token.id);
    form.appendChild(hiddenInput);
    form.submit();
  }
}
