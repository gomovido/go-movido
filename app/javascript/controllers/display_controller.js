import { Controller } from "stimulus"

export default class extends Controller {
  show() {
    const element = this.element.nextElementSibling;
    element.style.display == "none" ? element.style.display = "" : element.style.display = "none";
  }
}
