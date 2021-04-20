import mapboxgl from 'mapbox-gl';
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';
import '@mapbox/mapbox-gl-geocoder/dist/mapbox-gl-geocoder.css';

export const mapBoxAutocomplete = (element, localevalue) => {
  mapboxgl.accessToken = process.env.MAPBOX_API_KEY;
  const geocoder = new MapboxGeocoder({
    accessToken: mapboxgl.accessToken,
    autocomplete: true,
    types: 'postcode,district,place,locality,neighborhood,address,poi',
    countries: 'FR,GB',
    language: 'en',
    placeholder: setPlaceholder(localevalue)
  });
  geocoder.addTo(element);
  return geocoder
}

const setPlaceholder = (localevalue) => {
  if (localevalue === 'en') {
    return 'Enter your location or university'
  } else if (localevalue === 'fr') {
    return 'Saisissez votre lieu de résidence ou votre université'
  }
}

export const mapboxMap = (element, lng, lat, coordinates) => {
  mapboxgl.accessToken = process.env.MAPBOX_API_KEY;
  const map = new mapboxgl.Map({
    container: element,
    style: 'mapbox://styles/mapbox/streets-v11',
    center: [lng, lat],
    zoom: 15
  });
  coordinates.forEach((marker) => {
    new mapboxgl.Marker()
    .setLngLat([marker.coordinates.lng, marker.coordinates.lat])
    .addTo(map);
  });
}
