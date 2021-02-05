import ApplicationController from './application_controller'

export default class extends ApplicationController {
  static targets = ['container', 'leftArrow', 'rightArrow', 'card', 'dropdown']

  displayCard(event) {
    const card = this.cardTargets.find(card => card.dataset.serviceName === event.currentTarget.dataset.serviceName);
    card.classList.toggle('open-card')
    card.getElementsByClassName("card-link")[0].classList.toggle('d-none')
    let icon = card.getElementsByClassName("far")[0]
    if (icon) {
      icon.classList.toggle('fa-plus')
      icon.classList.toggle('fa-window-minimize')
    }
  }

  displayProductCard(event) {
    const card = this.cardTargets.find(card => card.dataset.serviceName === event.currentTarget.dataset.serviceName);
    card.classList.toggle('product-open-card')
    this.dropdownTarget.classList.toggle('d-none')
  }

  slideRight() {
    this.containerTarget.scrollLeft += 2000;
    this.css(this.leftArrowTarget, this.rightArrowTarget);
  }

  slideLeft() {
    this.containerTarget.scrollLeft -= 2000;
    this.css(this.rightArrowTarget, this.leftArrowTarget);
  }

  css(newTarget, oldTarget) {
    oldTarget.classList.remove('purple')
    oldTarget.classList.add('light-purple')
    newTarget.classList.remove('light-purple')
    newTarget.classList.add('purple')
  }

  updateButton(event) {
    let id = event.target.dataset.product;
    document.querySelector('#addressButton').href=`/categories/wifi/products/${id}/subscriptions`
  }

}
