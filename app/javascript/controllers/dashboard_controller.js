import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ "purple", "starter", "settleIn" ]

  togglePurpleBar() {
    const purpleBar = this.purpleTarget;
    if (this.settleInTarget.classList.contains("active") && !this.starterTarget.classList.contains("active")) {
      purpleBar.classList.add("active");
    } else {
      purpleBar.classList.remove("active");
    };
  };
}