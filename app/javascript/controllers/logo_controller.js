import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "word", 'count' ]

  connect() {
    setInterval(this.updateTitle.bind(this), 780);
  }

  updateTitle() {
    let index = [1 + (+this.countTarget.value)]
    if (index >= 6) { index = 0 }
    this.wordTarget.innerText = ['Housing?', 'Local Sim card?', 'WiFi?', "Utilities?", 'Public transportation?', 'Airport Pickup?'][index]
    this.countTarget.value = index
  }
};
