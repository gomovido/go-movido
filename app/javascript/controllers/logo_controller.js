import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "need" ]
  connect() {
    const speed = 50;
    let i = 0;
    const word = "Housing";
    const typeWriter = () => {
      if (i < word.length) {
      console.log(word[i]);
      document.getElementById("need").innerHTML += word.charAt(i);
      i++;
      setTimeout(typeWriter, speed);
    }
  }
    typeWriter();
  };
};