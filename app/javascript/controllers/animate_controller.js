import ApplicationController from './application_controller'

export default class extends ApplicationController {
  static targets = ['container', 'leftArrow', 'rightArrow']


  displayCard(event) {
    let service = event.currentTarget.dataset.serviceName
    document.getElementById(service).classList.toggle('open-card')
    document.getElementById(service).getElementsByClassName("card-link")[0].classList.toggle('d-none')
    let icon = document.getElementById(service).getElementsByClassName("far")[0]
    if (icon) {
      icon.classList.toggle('fa-plus')
      icon.classList.toggle('fa-window-minimize')
    }
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

}
