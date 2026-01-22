// app/javascript/controllers/index.js
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
// controllers フォルダ内の全コントローラーを自動登録
eagerLoadControllersFrom("controllers", application)