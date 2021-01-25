import ApplicationController from './application_controller'

export default class extends ApplicationController {

  loadModal(event) {
    $(".product-body").load(event.target.getAttribute("data-href"));
  }

  loadSubscriptionModal(event) {
    $('.modal-body').load(event.target.getAttribute("data-href"));
  }

  updateButton(event) {
    let id = event.target.dataset.product;
    document.querySelector('#addressButton').href=`/categories/wifi/products/${id}/subscriptions`
  }
}
