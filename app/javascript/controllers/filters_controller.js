import ApplicationController from './application_controller'
import noUiSlider from 'nouislider';
import 'nouislider/distribute/nouislider.css';
import Shuffle from 'shufflejs';

export default class extends ApplicationController {
  static targets = ['input']

  connect() {
    this.slider = this.inputTarget;
    noUiSlider.create(this.slider, {
      start: [1, 50],
      connect: true,
      step: 1,
      range: {
          'min': 1,
          'max': 50
      }
    });
    this.shuffleInstance = new Shuffle(document.querySelector('.products-cards-wrapper'), {
      itemSelector: '.product-card',
      size: 652
    });
    Shuffle.options = {
      filterMode: Shuffle.FilterMode.ALL
    }
    this.slider.noUiSlider.on('change.one', () => {
      document.getElementById('min').innerText = parseInt(this.slider.noUiSlider.get()[0], 10);
      document.getElementById('max').innerText = parseInt(this.slider.noUiSlider.get()[1], 10);
      if (document.getElementById('unlimited_data')) {
        this.mobileFilter();
      } else {
        this.wifiFilter();
      }
    });
  }

  mobileFilter() {
    this.baseFilter(this.mobileFiltersArray())
  }

  wifiFilter() {
    this.baseFilter(this.wifiFiltersArray())
  }

  baseFilter(arrayFilters) {
    this.shuffleInstance.filter((element) => {
      let min = parseInt(this.slider.noUiSlider.get()[0], 10)
      let max = parseInt(this.slider.noUiSlider.get()[1], 10)
      let productPrice = parseInt(element.dataset.price, 10)
      if (productPrice >= min && productPrice <= max && this.arrayEquals(arrayFilters, JSON.parse(element.dataset.groups)))
      return element;
    });
  }

  wifiFiltersArray() {
    let filters = [];
    if (document.getElementById('with_obligation').checked) {
      filters.push('u_obligation');
    } if (document.getElementById('without_obligation').checked) {
      filters.push('l_obligation');
    }
    return filters;
  }

  mobileFiltersArray() {
    let filters = [];
    if (document.getElementById('unlimited_data').checked) {
      filters.push('u_data');
    } if (document.getElementById('unlimited_call').checked) {
      filters.push('u_call');
    } if (document.getElementById('obligation').checked) {
      filters.push('no_ob');
    }
    return filters;
  }

  arrayEquals(a, b) {
    if (Array.from(document.querySelectorAll('input')).some(checkbox => checkbox.checked)) {
      return Array.isArray(a) && Array.isArray(b) && a.length === b.length && a.every((val, index) => val === b[index]);
    } else {
      return true;
    }
  }
}







