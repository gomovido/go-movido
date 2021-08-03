import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "word", 'count' ]

  connect() {
    setInterval(this.updateTitle.bind(this), 2000);
  }

  updateTitle() {
    let index = [1 + (+this.countTarget.value)]
    if (index >= 6) { index = 0 }
    this.typeSentence(['Public Transportation','Housing', 'Sim Card', 'Wifi at home', 'Airport Pickup', 'Gaz', 'Energy'][index])
    this.countTarget.value = index
  }

  async typeSentence(sentence, delay = 70) {
    const letters = sentence.split("");
    this.wordTarget.innerText = ''
    let i = 0;
    while(i < letters.length) {
      await this.waitForMs(delay);
      this.wordTarget.append(letters[i]);
      i++
    }
    return;
  }

  waitForMs(ms) {
    return new Promise(resolve => setTimeout(resolve, ms))
  }
};
