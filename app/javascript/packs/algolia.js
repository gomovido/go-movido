const places = require('places.js');
export default function displayAddressAutocomplete(element) {
    const placesAutocomplete = places({
      appId: 'pl32PKK41FYV',
      apiKey: '40d7e2e6a30185453dfe6ae9ba07433f',
      container: element,
      countries: ['FR', 'GB']
    });
    placesAutocomplete.on('change', (e) => {
      document.querySelector('#user_addresses_attributes_0_zipcode').value = e.suggestion.postcode
      document.querySelector('#user_addresses_attributes_0_country').value = e.suggestion.country
      document.querySelector('#user_addresses_attributes_0_city').value = e.suggestion.county
    });
}

export function displayBillingAutocomplete(element) {
  const placesAutocomplete = places({
    appId: 'pl32PKK41FYV',
    apiKey: '40d7e2e6a30185453dfe6ae9ba07433f',
    container: element
  });
}

export function displayBirthCityAutocomplete(element) {
  const placesAutocomplete = places({
    appId: 'pl32PKK41FYV',
    apiKey: '40d7e2e6a30185453dfe6ae9ba07433f',
    container: element,
    type: 'city'
  });
}
