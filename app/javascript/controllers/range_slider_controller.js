import ApplicationController from './application_controller'
import noUiSlider from 'nouislider';
import 'nouislider/distribute/nouislider.css';

export default class extends ApplicationController {
  static targets = ['input']

  connect() {
    let l = 1
    let h = 80
    var url = document.location.search.split('=')
    if (url.length > 2) {
      l = url[url.length - 2].slice(0,2).replace(/[^a-zA-Z0-9]/g, '')
      h = url[url.length - 1].slice(0,2).replace(/[^a-zA-Z0-9]/g, '')
      document.getElementById('q_price_gteq').value = l
      document.getElementById('q_price_lteq').value = h
    }
    var slider = this.inputTarget;
    noUiSlider.create(slider, {
        start: [l, h],
        connect: true,
        step: 1,
        range: {
            'min': 1,
            'max': 100
        }
    });
    slider.noUiSlider.on('change.one', function (e) {
      document.getElementById('q_price_gteq').value = parseInt(e[0])
      document.getElementById('q_price_lteq').value = parseInt(e[1])
     });
  }

}







