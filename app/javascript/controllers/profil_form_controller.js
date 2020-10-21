import ApplicationController from './application_controller'
import phoneInput from '../packs/phone-input';


export default class extends ApplicationController {
  static targets = ['phone', 'submit', 'input']

  toggleInput(event) {
    const activeElement = document.getElementsByClassName('active')[0]
    const input = this.inputTargets.find(input => input.id == event.target.dataset.id)
    if (event.target.dataset.id === 'phone') {
      phoneInput(this.phoneTarget);
      this.phoneTarget.value = document.getElementById('user_phone').dataset.value
    }
    if (activeElement && activeElement != input) {
      activeElement.classList.add('d-none')
      activeElement.classList.remove('active')
    }
    input.classList.toggle('d-none');
    input.classList.toggle('active');
  }

  togglePen(event) {
    $(".fa-pen").each(function() {
        $(this).addClass("d-none");
    });
    document.getElementsByClassName('fa-pen')[event.target.getAttribute('data-id')].classList.remove('d-none')
  }

}
