const places = require('places.js');
export default function displayAddressAutocomplete(element) {
    const placesAutocomplete = places({
      appId: 'pl32PKK41FYV',
      apiKey: '40d7e2e6a30185453dfe6ae9ba07433f',
      container: element
    });
}

