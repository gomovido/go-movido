import { Controller } from "stimulus";

export default class extends Controller {

  connect() {
    this.privacy(document, 'script', 'termly-jssdk');
  }
  privacy(d, s, id) {
    var js, tjs = d.getElementsByTagName(s)[0];
    js = d.createElement(s);
    js.id = id;
    js.src = "https://app.termly.io/embed-policy.min.js";
    tjs.parentNode.insertBefore(js, tjs);
  };
}
