import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ "navbar"]
  static classes = [ "fixed" ]

  onScroll() {
    if (document.body.scrollTop > 1 || document.documentElement.scrollTop > 1) {
      this.navbarTarget.classList.add(this.fixedClass);
    } else if (document.body.scrollTop < 1 || document.documentElement.scrollTop < 1) {
      this.navbarTarget.classList.remove(this.fixedClass);
    }
  }
}
