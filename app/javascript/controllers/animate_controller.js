import ApplicationController from './application_controller'

export default class extends ApplicationController {
  static targets = ['container', 'leftArrow', 'rightArrow']

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
