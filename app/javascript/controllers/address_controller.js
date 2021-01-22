import { Controller } from "stimulus";
import phoneInput from '../packs/phone-input';

export default class extends Controller {
  static targets = ["phone"]

  connect() {
    phoneInput(this.phoneTarget);

  }
}
