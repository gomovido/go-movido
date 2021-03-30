import { Controller } from "stimulus"
import Rails from "@rails/ujs";
import StimulusReflex from 'stimulus_reflex';
import noUiSlider from 'nouislider';
import 'nouislider/distribute/nouislider.css';

export default class extends Controller {
  static targets = ["entries", "pagination", "spinner", "form", "spinner", "slider"]

  initialize() {
    this.intersectionObserver = new IntersectionObserver(entries => this.processIntersectionEntries(entries))
  }

  connect() {
    this.intersectionObserver.observe(this.paginationTarget)
    StimulusReflex.register(this)
    this.slider = this.sliderTarget;
    const minPrice = parseInt(document.getElementById('filters_min').value);
    const maxPrice = parseInt(document.getElementById('filters_max').value);
    this.rangeSlider(minPrice, maxPrice);
  }


  rangeSlider(minPrice, maxPrice) {
    noUiSlider.create(this.slider, {
      start: [minPrice, maxPrice],
      connect: true,
      step: 1,
      range: {
          'min': minPrice,
          'max': maxPrice
      }
    });
    this.slider.noUiSlider.on('change.one', () => {
      const dateValue = document.getElementById('date-input').value
      document.getElementById('filters_min').value = parseInt(this.slider.noUiSlider.get()[0], 10);
      document.getElementById('filters_max').value = parseInt(this.slider.noUiSlider.get()[1], 10);
      this.stimulate('flatReflex#filter', this.formTarget, dateValue)
    });
  }

  disconnect() {
    this.intersectionObserver.unobserve(this.paginationTarget)
  }


  afterReflex(e) {
    let old_url = document.querySelector("a[rel='next']").getAttribute("href");
    document.querySelector("a[rel='next']").href = old_url.replace(/.$/,"2");
    this.hideLoading(this.spinnerTarget, this.entriesTarget)
    document.querySelector('.dates_dates').classList.remove('disabled');
  }

  filterByFacility(e) {
    const dateValue = document.getElementById('date-input').value
    this.triggerLoading(this.spinnerTarget, this.entriesTarget)
    this.stimulate('flatReflex#filter', this.formTarget, dateValue )
  }

  filterByDates(e) {
    if (e.currentTarget.value.split(' ').length === 3) {
      document.querySelector('.dates_dates').classList.add('disabled');
      this.triggerLoading(this.spinnerTarget, this.entriesTarget)
      this.stimulate('Flat#filter', e.currentTarget.value);
    }
  }

  triggerLoading(spinner, wrapper) {
    spinner.classList.remove('d-none');
    spinner.classList.add('middle');
    wrapper.classList.add('opacity');
  }

  hideLoading(spinner, wrapper) {
    spinner.classList.add('d-none')
    spinner.classList.remove('middle');
    wrapper.classList.remove('opacity');
  }

  processIntersectionEntries(entries) {
    entries.forEach(entry => {
      if (entry.isIntersecting && !document.querySelector('.flats-wrapper').classList.contains('opacity')) {
        this.loadMore()
      }
    })
  }

  loadMore() {
    let next_page = this.paginationTarget.querySelector("a[rel='next']");
    if (next_page == null) {
      this.spinnerTarget.classList.add('d-none');
      return
    }
    this.spinnerTarget.classList.remove('d-none');
    let url = next_page.href
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
