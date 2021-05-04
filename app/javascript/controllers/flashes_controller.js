import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ "flash"]

  connect() {
    setTimeout(() => {
      this.flashTarget.style.transition = '.5s';
      this.flashTarget.style.opacity = '0';
      this.flashTarget.style.visibility = 'hidden';
    }, (this.flashTarget.classList.contains('confirmation-flash') ? 10000 : 3000));
  }
}
