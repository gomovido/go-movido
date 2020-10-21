import intlTelInput from 'intl-tel-input';

export default function phoneInput(element) {
  intlTelInput(element, {
    preferredCountries: ['fr']
  });
  element.value = `+${document.querySelector('.iti__active').getAttribute('data-dial-code')}`;
  const countries = document.querySelectorAll('.iti__country');
  countries.forEach((country) => {
    country.addEventListener('click', () => {
      element.value = `+${country.getAttribute('data-dial-code')}`;
    })
  })
}

