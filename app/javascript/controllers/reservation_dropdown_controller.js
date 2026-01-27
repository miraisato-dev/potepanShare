// app/javascript/controllers/reservation_dropdown_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        const wrapper = this.element
        const button = wrapper.querySelector(".reservation-dropdown-toggle")
        if (button) {
            button.addEventListener("click", (e) => {
                e.stopPropagation()
                wrapper.classList.toggle("active")
            })
        }

        document.addEventListener("click", () => {
            document.querySelectorAll(".reservation-dropdown-wrapper.active").forEach((w) => w.classList.remove("active"))
        })
    }
}
