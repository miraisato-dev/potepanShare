// app/javascript/controllers/index.js
import { Application } from "@hotwired/stimulus"
import ReservationDropdownController from "./reservation_dropdown_controller"

const application = Application.start()
application.register("reservation-dropdown", ReservationDropdownController)

window.Stimulus = application
export { application }  // ← ここを追加


document.addEventListener("DOMContentLoaded", () => {
    const priceData = document.getElementById("price-data");
    if (!priceData) return;

    const pricePerNight = Number(priceData.dataset.price);
    const guestInput = document.getElementById("guest_count");
    const startDate = document.getElementById("start_date");
    const endDate = document.getElementById("end_date");
    const totalPrice = document.getElementById("total-price");

    function calculate() {
        if (!startDate.value || !endDate.value || !guestInput.value) return;

        const start = new Date(startDate.value);
        const end = new Date(endDate.value);
        const nights = (end - start) / (1000 * 60 * 60 * 24);

        if (nights > 0) {
            const total = pricePerNight * Number(guestInput.value) * nights;
            totalPrice.textContent = total.toLocaleString();
        }
    }

    guestInput.addEventListener("input", calculate);
    startDate.addEventListener("change", calculate);
    endDate.addEventListener("change", calculate);
});