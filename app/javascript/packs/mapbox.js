import mapboxgl from 'mapbox-gl';
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';
import '@mapbox/mapbox-gl-geocoder/dist/mapbox-gl-geocoder.css';

export const mapBoxAutocomplete = (element, localevalue) => {
  mapboxgl.accessToken = process.env.MAPBOX_API_KEY;
  const geocoder = new MapboxGeocoder({
    accessToken: mapboxgl.accessToken,
    autocomplete: true,
    types: 'address, place, postcode, locality, region',
    language: 'en'
  });
  geocoder.addTo(element);
  return geocoder
}


export const mapBoxRestrictedAutocomplete = (element, localevalue) => {
  mapboxgl.accessToken = process.env.MAPBOX_API_KEY;
  const geocoder = new MapboxGeocoder({
    accessToken: mapboxgl.accessToken,
    autocomplete: true,
    types: 'address',
    language: 'en',
    countries: 'fr, gb',
  });
  geocoder.addTo(element);
  return geocoder
}

