const places = require('places.js');
const language = document.querySelector("body").getAttribute("data-locale");

export default function displayAddressAutocomplete(element) {
    const placesAutocomplete = places({
      language: language,
      appId: 'pl32PKK41FYV',
      apiKey: '40d7e2e6a30185453dfe6ae9ba07433f',
      container: element,
      countries: ['FR', 'GB']
    });
    placesAutocomplete.on('change', (e) => {
      document.querySelector('#address_zipcode').value = e.suggestion.postcode
      document.querySelector('#address_country').value = e.suggestion.country
      document.querySelector('#address_city').value = e.suggestion.county
    });
}

export function displayBillingAutocomplete(element) {
  places({
    language: language,
    appId: 'pl32PKK41FYV',
    apiKey: '40d7e2e6a30185453dfe6ae9ba07433f',
    container: element
  });
}

export function displayBirthCityAutocomplete(element) {
  return places({
    language: language,
    appId: 'pl32PKK41FYV',
    apiKey: '40d7e2e6a30185453dfe6ae9ba07433f',
    container: element,
    type: 'city'
  });
}
  export function displayCityMovingAutocomplete(element, country) {
    element.configure({countries: [country]})
}
