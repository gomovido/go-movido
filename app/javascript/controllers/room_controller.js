import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ['card', 'body']

  onClick(event) {
    const cards = this.cardTargets;
    let activeCard = cards.find(card => card.dataset.id === event.currentTarget.dataset.id);
    let activeBody = this.bodyTargets.find(body => body.dataset.id === event.currentTarget.dataset.id);
    let oldBody = this.bodyTargets.find(body => (body.dataset.id !== event.currentTarget.dataset.id) && !body.classList.contains('d-none'));
    cards.forEach(card => {
      if (card === activeCard) {
        card.classList.add('room-selected');
        activeBody.classList.remove('d-none');
      } else {
        card.classList.remove('room-selected');
        if (oldBody) {
          oldBody.classList.add('d-none')
        }
      }
    });
  }

}
