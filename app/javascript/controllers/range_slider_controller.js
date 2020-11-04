import ApplicationController from './application_controller'
import noUiSlider from 'nouislider';
import 'nouislider/distribute/nouislider.css';

export default class extends ApplicationController {
  static targets = ['input']

  connect() {
    let l = 20.00
    let h = 80.00
    var url = document.location.search.split('=')
    if (url.length > 2) {
      l = url[url.length - 2].slice(0,5)
      h = url[url.length - 1].slice(0,5)
      document.getElementById('q_price_gteq').value = l
      document.getElementById('q_price_lteq').value = h
    }
    var slider = this.inputTarget;
    noUiSlider.create(slider, {
        start: [l, h],
        connect: true,
        range: {
            'min': 10,
            'max': 100
        }
    });
    slider.noUiSlider.on('change.one', function (e) {
      document.getElementById('q_price_gteq').value = e[0]
      document.getElementById('q_price_lteq').value = e[1]
     });
  }

}







