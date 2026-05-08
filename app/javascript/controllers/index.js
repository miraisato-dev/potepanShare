// app/javascript/controllers/index.js

import { application } from "./application"

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import ReservationDropdownController from "./reservation_dropdown_controller"
application.register("reservation-dropdown", ReservationDropdownController)

import RoomReservationController from "./room_reservation_controller"
application.register("room-reservation", RoomReservationController)

import UserMenuController from "./user_menu_controller"
application.register("user-menu", UserMenuController)