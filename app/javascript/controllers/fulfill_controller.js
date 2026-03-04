import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="fulfill"
export default class extends Controller {
  static targets = ["fulfillableElement"]
  static values = { text: String , originalText: String , fulfilled: Boolean }

  connect() {
    console.log("Hello from fulfill")
  }

  switch () {
    this.fulfillableElementTarget.classList.toggle("btn-primary")
    // this.fulfillableElementTarget.classList.remove("btn-primary")
    // this.fulfillableElementTarget.classList.add("btn-secondary")



    this.fulfillableElementTarget.innerText = this.fulfilledValue === false ? this.textValue : this.originalTextValue;
  }
}
