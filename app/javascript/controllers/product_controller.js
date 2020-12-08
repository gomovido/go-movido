import ApplicationController from './application_controller'

export default class extends ApplicationController {
  static targets = ['modalBody', 'link']

  loadProduct(event) {
    $(".modal-body").load(event.target.getAttribute("data-href"));
  }
  redirect() {
    if (event.target.dataset.target !== '#exampleModal') {
      this.linkTargets[0].click();
    }
  }
}
