import ApplicationController from './application_controller'
import phoneInput from '../packs/phone-input';


export default class extends ApplicationController {
  static targets = ['phone', 'submit']


  connect() {
    phoneInput(this.phoneTarget);
    this.phoneTarget.value = document.getElementById('user_phone').getAttribute('data-value')
  }

  toggleInput(event) {
    const activeElement = document.getElementsByClassName('active')[0]
    const element = document.getElementById(event.target.getAttribute('data-id'))
    if (activeElement && activeElement != element) {
      activeElement.classList.add('d-none')
      activeElement.classList.remove('active')
    }
    element.classList.toggle('d-none')
    element.classList.toggle('active')
  }

  togglePen(event) {
    $(".fa-pen").each(function() {
        $(this).addClass("d-none");
    });
    document.getElementsByClassName('fa-pen')[event.target.getAttribute('data-id')].classList.remove('d-none')
  }
}
