import ApplicationController from './application_controller'

export default class extends ApplicationController {

  loadModal(event) {
    $(".product-body").load(event.target.getAttribute("data-href"));
  }


  loadBankModal(event) {
    $(".bank-body").load(event.target.getAttribute("data-href"));
  }

  loadSubscriptionModal(event) {
    $('.modal-body').load(event.target.getAttribute("data-href"));
  }

  updateButton(event) {
    console.log(event.target)
    let id = event.target.dataset.product;
    document.querySelector('#addressButton').href=`/subscriptions?&product_id=${id}&product_type=Wifi`
  }
}
