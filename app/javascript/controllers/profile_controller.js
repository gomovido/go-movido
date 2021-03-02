import { Controller } from 'stimulus'
import phoneInput from '../packs/phone-input';
import StimulusReflex from 'stimulus_reflex';
import {addressAutocomplete, searchByCity, searchByCountry, autoFill} from '../packs/algolia';
const places = require('places.js');

export default class extends Controller {
  static targets = ['phone', 'input', 'addressInput', 'addAddressInput', 'addAddressButton', 'birthCity', 'errors', 'spinner', 'savingText', 'wheel'];
  static classes = [ 'hide', 'flex', 'readonly' ]
  static values = { locale: String, countries: String }

  connect() {
    StimulusReflex.register(this);
    this.birthCity = addressAutocomplete(this.birthCityTarget);
    searchByCity(this.birthCity);
    phoneInput(this.phoneTarget);
    this.phoneTarget.value = document.getElementById('user_person_attributes_phone').value;
  }

  updateNavbar(event) {
    if (event.target.value) {
      document.getElementById('profileNavbar').innerText = document.getElementById('user_first_name').value + ' ' + document.getElementById('user_last_name').value;
    }
  }

  afterSubmit(event, response, error) {
    window.scroll({
      top: 0,
      left: 0,
      behavior: 'smooth'
    });
    console.log('Submitted Safari')
    if (error) {
      let errors = this.localeValue === 'fr' ? error.replace("La validation a échoué : ", "").replace(/,/g, '<br>') : error.replace("Validation failed: ", "").replace(/,/g, '<br>');
      this.errorsTarget.innerHTML = "";
      this.errorsTarget.insertAdjacentHTML('beforeend', errors);
    } else {
      this.connect();
      this.spinnerTarget.classList.add('show');
      setTimeout(() => {
        this.wheelTarget.outerHTML = `<i class="fas fa-check text-success"></i>`
        if (this.localeValue === 'fr') {
          this.savingTextTarget.innerHTML = `Profil mis à jour`
        } else {
          this.savingTextTarget.innerHTML = `Profile updated`
        }
        setTimeout(() => {
          this.spinnerTarget.classList.remove('show');
        }, 1500);
      }, 1100);
    }
  }

  cleanCountryCode() {
    document.querySelector('#algolia_country_code').value = ""
  }


  toggleAddressAutocomplete() {
    this.movingStreet = addressAutocomplete(this.addressInputTarget);
    searchByCountry(this.movingStreet, JSON.parse(this.countriesValue));
    autoFill(this.movingStreet);
    this.addAddressInputTarget.classList.remove(this.hideClass);
    this.addAddressInputTarget.classList.add(this.flexClass);
    this.addAddressButtonTarget.classList.add(this.hideClass);
    this.addAddressButtonTarget.classList.remove(this.flexClass);
  }
}
