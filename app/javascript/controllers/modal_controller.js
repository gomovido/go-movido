import ApplicationController from './application_controller'

export default class extends ApplicationController {
  static targets = ['modalBody']

  loadModal(event) {
    $(".modal-body").load(event.target.getAttribute("data-href"));
  }
}
