import { Controller } from "stimulus";
import numeral from "numeral";

export default class extends Controller {
  static targets = [ "purple", "starter", "settleIn"]

  togglePurpleBar() {
    const purpleBar = this.purpleTarget;
    if (this.starterTarget.classList.contains("active") && !this.settleInTarget.classList.contains("active")) {
      purpleBar.classList.add("active");
    } else {
      purpleBar.classList.remove("active");
    };
  };

}
