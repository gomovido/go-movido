import { Controller } from "stimulus"
import Rails from "@rails/ujs";

export default class extends Controller {
  static targets = ["entries", "pagination", "spinner"]

  initialize() {
    this.intersectionObserver = new IntersectionObserver(entries => this.processIntersectionEntries(entries))
  }

  connect() {
    this.intersectionObserver.observe(this.paginationTarget)
  }

  disconnect() {
    this.intersectionObserver.unobserve(this.paginationTarget)
  }

  processIntersectionEntries(entries) {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        if (!document.querySelector('.flats-wrapper').classList.contains('opacity')) {
          this.loadMore()
        }
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
