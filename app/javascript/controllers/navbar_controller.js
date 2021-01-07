import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ "navbar", "language", "services", "profile"]
  static classes = [ "fixed" ]

  connect() {
    $('#languageDropdown').on('show.bs.dropdown', () => {
      this.languageTarget.style.setProperty("color", "#8C30F5", "important");
    });
    $('#languageDropdown').on('hide.bs.dropdown', () => {
      this.languageTarget.style.setProperty("color", "#000000", "important");
    });
    $('#servicesDropdown').on('show.bs.dropdown', () => {
      this.servicesTarget.style.setProperty("color", "#8C30F5", "important");
    });
    $('#servicesDropdown').on('hide.bs.dropdown', () => {
      this.servicesTarget.style.setProperty("color", "#000000", "important");
    });
    $('#userDropdown').on('show.bs.dropdown', () => {
      this.profileTarget.classList.add('active');
    });
    $('#userDropdown').on('hide.bs.dropdown', () => {
      this.profileTarget.classList.remove('active');
    });
  }

  onScroll() {
    if (document.body.scrollTop > 1 || document.documentElement.scrollTop > 1) {
      this.navbarTarget.classList.add(this.fixedClass);
    } else if (document.body.scrollTop < 1 || document.documentElement.scrollTop < 1) {
      this.navbarTarget.classList.remove(this.fixedClass);
    }
  }
}
