const places = require('places.js');

export function addressAutocomplete(element) {
  return places({
    language: 'en',
    appId: process.env.ALGOLIA_APP_ID,
    apiKey: process.env.ALGOLIA_API_KEY,
    container: element,
    type: 'address'
  });
}

export function autoFill(element) {
  element.on('change', (e) => {
    document.querySelector('#address_zipcode').value = e.suggestion.postcode
    document.querySelector('#address_city').value = e.suggestion.county
  });
}

export function searchByCity(element) {
  element.configure({type: 'city'})
}


export function searchByCountry(element, country) {
  element.configure({countries: country})
}
