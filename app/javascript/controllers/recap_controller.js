import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="recap"
export default class extends Controller {
  static values = {cart: Array, total: Number}
  static targets = ["cart"]

  connect() {
    console.log("recap controller")
    this.cartValue = JSON.parse(localStorage.getItem("cart"))

    let total = 0
    for (let i=0; i < this.cartValue.length; i++) {
      const item = this.cartValue[i]
      total += item.price * item.quantity
      const div = document.createElement("div")
      div.classList.add("mt-2")
      div.innerText = `Item: ${item.name} - $${item.price} - Size: ${item.size} - Quantity: ${item.quantity}`
      console.log("item.id: ", item.id)
      this.element.prepend(div)
    }

    const totalEl = document.createElement("div")
    totalEl.innerText= `Total: $${total}`
    let totalContainer = document.getElementById("total")
    totalContainer.appendChild(totalEl)
    this.totalValue = total
    console.log(this.totalValue)
  }

    checkout() {
    this.cartValue = JSON.parse(localStorage.getItem("cart"))
    console.log(this.cartValue)
    const payload = {
      authenticity_token: "",
      cart: this.cartValue,
      total: this.totalValue
    }

    const csrfToken = document.querySelector("[name='csrf-token']").content

    fetch("/orders/checkout", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": csrfToken
      },
      body: JSON.stringify(payload)
    }).then(response => {
        if (response.ok) {
          response.json().then(body => {
            localStorage.removeItem("cart"),
            window.location.href = body.url
          })
        } else {
          response.json().then(body => {
            const errorEl = document.createElement("div")
            errorEl.innerText = `There was an error processing your order. ${body.error}`
            let errorContainer = document.getElementById("errorContainer")
            errorContainer.appendChild(errorEl)
          })
        }
      })
  }

}
