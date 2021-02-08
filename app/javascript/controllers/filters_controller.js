import ApplicationController from './application_controller'
import noUiSlider from 'nouislider';
import 'nouislider/distribute/nouislider.css';
import Shuffle from 'shufflejs';

export default class extends ApplicationController {
  static targets = ['input', 'noResult']

  connect() {
    console.log('done')
    $(window).bind("pageshow", function(event) {
      if (event.originalEvent.persisted) {
        window.location.reload()
      }
    });
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
        this.checkProducts();
      } else {
        this.wifiFilter();
        this.checkProducts();
      }
    });
  }

  displayProductCard(event) {
    event.currentTarget.classList.toggle('product-open-card');
    event.currentTarget.querySelector('.dropdown-card').classList.toggle('d-none');
    this.shuffleInstance.update();
  }

  mobileFilter() {
    this.baseFilter(this.mobileFiltersArray());
    this.checkProducts();
  }

  wifiFilter() {
    this.baseFilter(this.wifiFiltersArray());
    this.checkProducts();
  }

  checkProducts() {
    if (document.querySelectorAll('.shuffle-item--visible').length === 0) {
      this.noResultTarget.classList.remove('d-none');
    } else {
      this.noResultTarget.classList.add('d-none')
    }
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
      filters.push('with_obligation');
    } if (document.getElementById('without_obligation').checked) {
      filters.push('without_obligation');
    }
    return filters;
  }

  mobileFiltersArray() {
    let filters = [];
    if (document.getElementById('unlimited_data').checked) {
      filters.push('unlimited_data');
    } if (document.getElementById('unlimited_call').checked) {
      filters.push('unlimited_call');
    } if (document.getElementById('without_obligation').checked) {
      filters.push('without_obligation');
    }
    return filters;
  }

  arrayEquals(filterArray, productArray) {
    if (Array.from(document.querySelectorAll('input')).some(checkbox => checkbox.checked)) {
      return Array.isArray(filterArray) && Array.isArray(productArray) && filterArray.every(val => productArray.includes(val));
    } else {
      return true;
    }
  }
}





