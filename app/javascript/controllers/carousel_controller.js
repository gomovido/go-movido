import { Controller } from "stimulus";
import { Application } from "stimulus"
import Carousel from "stimulus-carousel"


export default class extends Controller {

  connect() {
    const application = Application.start()
    application.register("carousel", Carousel)
  }

}
