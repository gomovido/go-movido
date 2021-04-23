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

export const mapboxMap = (element, markers, centerCoordinates) => {
  mapboxgl.accessToken = process.env.MAPBOX_MAP_STYLE_KEY;

  const map = new mapboxgl.Map({
    container: element,
    style: 'mapbox://styles/yonitou/cknq3xu9u0prp17qf31l80t8r',
    center: markers[0] ? [markers[0].coordinates.lng, markers[0].coordinates.lat] : centerCoordinates,
    zoom: 12
  });
  let marker = setMarkers(markers, map);
  if (marker) {
    marker.togglePopup()
  }
  return map
}


export const setMarkers = (markers, map) => {
  let mapMarkers = []
  markers.forEach((marker) => {
    let popup = new mapboxgl.Popup({ offset: 25, closeButton: false }).setHTML(
      `
        <div class="content p-1" style="background-image: url('${marker.img}')">
        <a class="title" href="${marker.url}">${marker.name.length > 20 ? marker.name.substring(0,20) + '...' : marker.name}</a>
        <span class="price pl-1">${marker.currency}${marker.price} / ${marker.frequency}</span>
        </div>
      `
      );
    let el = document.createElement('div');
    el.innerHTML = `<span class="price">${marker.currency}${marker.price}</span>`
    el.classList.add('marker')
    el.id = `marker-${marker.id}`;
    el.dataset.lng = marker.coordinates.lng;
    el.dataset.lat = marker.coordinates.lat;
    popup.on('close', () => el.classList.remove('active'));
    popup.on('open', () => el.classList.add('active'));
    let mapMarker = new mapboxgl.Marker(el)
      .setLngLat([marker.coordinates.lng, marker.coordinates.lat])
      .setPopup(popup)
      .addTo(map);
    mapMarkers.push(mapMarker)
  });
  return mapMarkers[0]
};
