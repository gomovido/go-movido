import intlTelInput from 'intl-tel-input';

export default function phoneInput(element) {
  intlTelInput(element, {
    preferredCountries: ['fr', 'gb']
  });
  if (!element.value) {
    element.value = document.querySelector('.iti__selected-flag').getAttribute('title').split(' ')[1];
  }
  const countries = document.querySelectorAll('.iti__country');
  countries.forEach((country) => {
    country.addEventListener('click', () => {
      element.value = `+${country.getAttribute('data-dial-code')}`;
    })
  })
}

