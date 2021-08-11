import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ "purple", "france", "uk" ]

  togglePurpleBar() {
    const purpleBar = this.purpleTarget;
    if (this.ukTarget.classList.contains("active") && !this.franceTarget.classList.contains("active")) {
      purpleBar.classList.add("active");
    } else {
      purpleBar.classList.remove("active");
    };
  };
}