// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")
require("flatpickr")

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------


// External imports
import "bootstrap";
import "flatpickr/dist/flatpickr.min.css"
import 'intl-tel-input/build/css/intlTelInput.css';
import 'swiper/swiper-bundle.min.css'
import "controllers"
import 'mapbox-gl/dist/mapbox-gl.css';


// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';
import cookie from './cookie_banner';

document.addEventListener('turbolinks:load', () => {
  if (process.env.RAILS_ENV === 'production') {gtag('config', process.env.GOOGLE_TAG_ID, {'page_location': event.data.url});}
  cookie();
});


