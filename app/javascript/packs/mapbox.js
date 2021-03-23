import mapboxgl from 'mapbox-gl';
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';
import '@mapbox/mapbox-gl-geocoder/dist/mapbox-gl-geocoder.css';

export function mapBoxAutocomplete(element, localevalue) {
  mapboxgl.accessToken = process.env.MAPBOX_API_KEY;
  const geocoder = new MapboxGeocoder({
    accessToken: mapboxgl.accessToken,
    autocomplete: true,
    types: 'region,postcode,district,place,locality,neighborhood,address,poi',
    countries: 'FR,GB',
    language: 'en',
    placeholder: setPlaceholder(localevalue)
  });
  return geocoder.addTo(element);
}

function setPlaceholder(localevalue) {
  if (localevalue === 'en') {
    return 'Where are you going?'
  } else if (localevalue === 'fr') {
    return 'Où allez-vous?'
  }
}
