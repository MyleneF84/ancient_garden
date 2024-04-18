import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="edit-profile"
export default class extends Controller {
  static targets = [ "infos", "form", "card" ]

  connect() {
  }

  displayForm() {
    this.infosTarget.classList.toggle('d-none');
    this.formTarget.classList.toggle('d-none');
  }

  update(event) {
    event.preventDefault();
    const url = this.formTarget.action
    fetch(url, {
      method: 'PATCH',
      headers: { 'Accept': 'text/html' },
      body: new FormData(this.formTarget)
    })
      .then(response => response.text())
      .then((data) => {
        this.cardTarget.outerHTML = data;
      })
      .catch(error => {
        console.error('Error:', error); 
      });
  }
}
