// app/javascript/controllers/user_menu_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const button = this.element.querySelector(".user-menu-toggle")

    button?.addEventListener("click", (e) => {
      e.stopPropagation()
      this.element.classList.toggle("active")
    })

    document.addEventListener("click", () => {
      this.element.classList.remove("active")
    })
  }
}
