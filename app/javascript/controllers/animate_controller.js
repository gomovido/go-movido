import ApplicationController from './application_controller'

export default class extends ApplicationController {
  static targets = ['container', 'leftArrow', 'rightArrow', 'card']

  displayCard(event) {
    const card = this.cardTargets.find(card => card.dataset.serviceName === event.currentTarget.dataset.serviceName);
    card.classList.toggle('open-card')
    card.getElementsByClassName("card-link")[0].classList.toggle('d-none')
    let icon = card.getElementsByClassName("far")[0]
    if (icon) {
      icon.classList.toggle('fa-plus')
      icon.classList.toggle('fa-window-minimize')
    }
  }

  slideRight() {
    this.containerTarget.scrollLeft += 2000;
    this.css(this.leftArrowTarget, this.rightArrowTarget);
  }

  slideLeft() {
    this.containerTarget.scrollLeft -= 2000;
    this.css(this.rightArrowTarget, this.leftArrowTarget);
  }

  css(newTarget, oldTarget) {
    oldTarget.classList.remove('purple')
    oldTarget.classList.add('light-purple')
    newTarget.classList.remove('light-purple')
    newTarget.classList.add('purple')
  }

  displaySubscriptionCard(event) {
    const cards = this.cardTargets;
    let activeCard = cards.find(card => card.dataset.id === event.currentTarget.dataset.id);
    cards.forEach(card => {
      if (card !== activeCard) {
        card.classList.remove('subscription-open-card');
        card.querySelector('.dropdown-card').classList.add('d-none');
      }
    });
    event.currentTarget.classList.toggle('subscription-open-card');
    event.currentTarget.querySelector('.dropdown-card').classList.toggle('d-none');
  }

  displayBankCard(event) {
    const cards = this.cardTargets;
    let activeCard = cards.find(card => card.dataset.id === event.currentTarget.dataset.id);
    cards.forEach(card => {
      if (card !== activeCard) {
        card.classList.remove('bank-open-card');
        card.querySelector('.dropdown-card').classList.add('d-none');
      }
    });
    event.currentTarget.classList.toggle('bank-open-card');
    event.currentTarget.querySelector('.dropdown-card').classList.toggle('d-none');
    event.currentTarget.scrollIntoView({behavior: "smooth"})
  }

  displayPurpleBackground(event) {
    const cards = this.cardTargets;
    let activeCard = cards.find(card => card.dataset.teamName === event.currentTarget.dataset.teamName);
    cards.forEach(card => {
      if (card !== activeCard) {
        card.querySelector('.inside').style.opacity = '0';
        card.querySelector('.purple-card').style.opacity = '0';
        card.querySelector('.purple-card').style.width = '0%';
      }
    });
    const card = cards.find(card => card.dataset.teamName === event.currentTarget.dataset.teamName);
    let inside = card.querySelector(".inside");
    let purpleCard = card.querySelector(".purple-card");
    inside.style.opacity === '1' ? inside.style.opacity = '0' : inside.style.opacity = '1';
    purpleCard.style.opacity === '0.8' ? purpleCard.style.opacity = '0' : purpleCard.style.opacity = '0.8';
    purpleCard.style.width === '100%' ? purpleCard.style.width = '0%' : purpleCard.style.width = '100%';
  }

}
