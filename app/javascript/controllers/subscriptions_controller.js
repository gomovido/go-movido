import { Controller } from "stimulus";
const places = require('places.js');

export default class extends Controller {
  static targets = [ "addressForm", "addressSummary", "addressInput"]

  connect() {}
}
