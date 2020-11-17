const places = require('places.js');

export default function displayAddressAutocomplete(element) {
    const placesAutocomplete = places({
      language: 'en',
      appId: process.env.ALGOLIA_APP_ID,
      apiKey: process.env.ALGOLIA_API_KEY,
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
  return places({
    language: 'en',
    appId: process.env.ALGOLIA_APP_ID,
    apiKey: process.env.ALGOLIA_API_KEY,
    container: element
  });
}

export function displayBirthCityAutocomplete(element) {
  return places({
    language: 'en',
    appId: process.env.ALGOLIA_APP_ID,
    apiKey: process.env.ALGOLIA_API_KEY,
    container: element,
    type: 'city'
  });
}
  export function displayCityMovingAutocomplete(element, country) {
    element.configure({countries: [country]})
}
