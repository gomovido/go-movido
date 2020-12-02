import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ "navbar"]

  onScroll() {
    if (document.body.scrollTop > 1 || document.documentElement.scrollTop > 1) {
      if(document.body.scrollHeight > document.body.clientHeight){
         this.navbarTarget.classList.add('fixed-nav')
}

    } else if (document.body.scrollTop < 1 || document.documentElement.scrollTop < 1) {
      this.navbarTarget.classList.remove('fixed-nav')
    }
  }
}
