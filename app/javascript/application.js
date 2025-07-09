// app/javascript/application.js
import "@hotwired/turbo-rails"

// 1) import the Stimulus core
import { Application } from "@hotwired/stimulus"

// 2) import your controller
import AutoSubmitController from "./controllers/auto_submit_controller.js"

// 3) start Stimulusccc
const application = Application.start()

// 4) register your controller under the name you used in data-controller
application.register("auto-submit", AutoSubmitController)
