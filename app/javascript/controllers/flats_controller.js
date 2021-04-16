import { Controller } from "stimulus"
import Rails from "@rails/ujs";
import StimulusReflex from 'stimulus_reflex';
import noUiSlider from 'nouislider';
import 'nouislider/distribute/nouislider.css';

export default class extends Controller {
  static targets = ["entries", "pagination", "spinner", "form", "slider"]

  initialize() {
    this.intersectionObserver = new IntersectionObserver(entries => this.processIntersectionEntries(entries))
  }

  connect() {
    this.intersectionObserver.observe(this.paginationTarget)
    StimulusReflex.register(this)
    this.slider = this.sliderTarget;
    const startMinPrice = parseInt(document.getElementById('flat_preference_range_min_price').value);
    const startMaxPrice = parseInt(document.getElementById('flat_preference_range_max_price').value);
    const rangeMinPrice = parseInt(document.getElementById('flat_preference_range_min_price').dataset.minValue);
    const rangeMaxPrice = parseInt(document.getElementById('flat_preference_range_max_price').dataset.maxValue)
    this.rangeSlider(startMinPrice, startMaxPrice, rangeMinPrice, rangeMaxPrice);
  }


  rangeSlider(startMinPrice, startMaxPrice, rangeMinPrice, rangeMaxPrice) {
    noUiSlider.create(this.slider, {
      start: [startMinPrice, startMaxPrice],
      connect: true,
      step: 1,
      range: {
        'min': rangeMinPrice,
        'max': rangeMaxPrice
      }
    });
    this.slider.noUiSlider.on('change.one', () => {
      document.getElementById('flat_preference_range_min_price').value = parseInt(this.slider.noUiSlider.get()[0], 10);
      document.getElementById('flat_preference_range_max_price').value = parseInt(this.slider.noUiSlider.get()[1], 10);
      this.triggerLoading(this.spinnerTarget, this.entriesTarget, this.formTarget, document.getElementById('date-input').value)
    });
  }

  disconnect() {
    this.intersectionObserver.unobserve(this.paginationTarget)
  }


  afterReflex(e) {
    const paginationLink = document.querySelector("a[rel='next']")
    if (paginationLink) {
      let old_url = paginationLink.getAttribute("href");
      document.querySelector("a[rel='next']").href = old_url.replace(/.$/,"2");
    }
    this.hideLoading(this.spinnerTarget, this.entriesTarget)
  }

  filterByFacility(e) {
    this.triggerLoading(this.spinnerTarget, this.entriesTarget, this.formTarget, document.getElementById('date-input').value)
  }

  filterByDates(e) {
    if (e.currentTarget.value.split(' ').length === 3) {
      this.triggerLoading(this.spinnerTarget, this.entriesTarget, this.formTarget, e.currentTarget.value)
    }
  }

  triggerLoading(spinner, wrapper, form, date) {
    document.querySelector('.flat_preference_move_in').classList.add('disabled');
    spinner.classList.remove('d-none');
    spinner.classList.add('middle');
    wrapper.classList.add('opacity');
    this.stimulate('FlatReflex#filter', form, date)
  }

  hideLoading(spinner, wrapper) {
    spinner.classList.add('d-none')
    spinner.classList.remove('middle');
    wrapper.classList.remove('opacity');
    document.querySelector('.flat_preference_move_in').classList.remove('disabled');
  }

  processIntersectionEntries(entries) {
    entries.forEach(entry => {
      if (entry.isIntersecting && !document.querySelector('.flats-wrapper').classList.contains('opacity')) {
        this.loadMore()
      }
    })
  }

  loadMore() {
    let nextPage = this.paginationTarget.querySelector("a[rel='next']");
    if (nextPage == null) {
      this.spinnerTarget.classList.add('d-none');
      return
    }
    this.spinnerTarget.classList.remove('d-none');
    let url = nextPage.href
    Rails.ajax({
      type: 'GET',
      url: url,
      dataType: 'json',
      success: (data) => {
        if (data.entries) {
          this.spinnerTarget.classList.add('d-none')
          this.entriesTarget.insertAdjacentHTML('beforeend', data.entries)
          this.paginationTarget.innerHTML = data.pagination
        } else {
          this.paginationTarget.innerHTML = data.pagination
          this.loadMore()
        }
      }
    })
  }
}
