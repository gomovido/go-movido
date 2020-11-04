import ApplicationController from './application_controller'
import phoneInput from '../packs/phone-input';


export default class extends ApplicationController {
  static targets = ['phone', 'submit', 'input', 'mobilePhone']

  connect() {
    phoneInput(this.mobilePhoneTarget);
  }
}
