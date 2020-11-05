import ApplicationController from './application_controller'

export default class extends ApplicationController {
  static targets = ['modalBody']

  loadProduct(event) {
    $(".modal-body").load(event.target.getAttribute("data-href"));
  }

}
