import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toast"
export default class extends Controller {
  static targets = ["message"]

  connect() {
    setTimeout(() => {
      this.remove()
    }, 5000) // Toast disappears after 5 seconds
  }

  remove() {
    this.messageTarget.classList.add("opacity-0", "transition-opacity", "duration-500", "ease-out")
    this.messageTarget.addEventListener("transitionend", () => {
      this.messageTarget.remove()
    }, { once: true })
  }
}
