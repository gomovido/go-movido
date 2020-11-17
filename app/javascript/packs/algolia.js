const places = require('places.js');

export function addressAutocomplete(element) {
  return places({
    language: 'en',
    appId: 'pl32PKK41FYV',
    apiKey: '40d7e2e6a30185453dfe6ae9ba07433f',
    container: element
  });
}

export function autoFill(element) {
  element.on('change', (e) => {
    document.querySelector('#address_zipcode').value = e.suggestion.postcode
    document.querySelector('#address_country').value = e.suggestion.country
    document.querySelector('#address_city').value = e.suggestion.county
  });
}

export function searchByCity(element) {
  element.configure({type: 'city'})
}
export function searchByCountry(element, country) {
  element.configure({countries: [country]})
}
