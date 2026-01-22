/* import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        console.log("room_reservation controller connected")

        const startInput = this.element.querySelector("#start_date")
        const endInput = this.element.querySelector("#end_date")
        const bookedEl = this.element.querySelector("#booked-dates")
        if (!startInput || !endInput || !bookedEl) return

        const bookedDates = bookedEl.dataset.dates.split(",").map(d => d.trim()).filter(d => d)

        window.flatpickr(startInput, { dateFormat: "Y-m-d", minDate: "today", disable: bookedDates })
        window.flatpickr(endInput, { dateFormat: "Y-m-d", minDate: "today", disable: bookedDates })
    }
} */
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        console.log("room_reservation controller connected")

        const startInput = this.element.querySelector("#start_date")
        const endInput = this.element.querySelector("#end_date")
        const bookedEl = this.element.querySelector("#booked-dates")
        if (!startInput || !endInput || !bookedEl) return

        const bookedDates = bookedEl.dataset.dates
            .split(",")
            .map(d => d.trim())
            .filter(d => d)

        // チェックアウト用 Flatpickr
        const endPicker = window.flatpickr(endInput, {
            dateFormat: "Y-m-d",
            minDate: "today",
            disable: bookedDates
        })

        // チェックイン用 Flatpickr
        window.flatpickr(startInput, {
            dateFormat: "Y-m-d",
            minDate: "today",
            disable: bookedDates,
            onChange: function (selectedDates) {
                if (selectedDates.length > 0) {
                    // チェックイン翌日から選択可能にする
                    const nextDay = selectedDates[0].fp_incr(1)
                    endPicker.set("minDate", nextDay)
                }
            }
        })
    }
}
