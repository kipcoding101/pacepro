// app/javascript/controllers/auto_submit_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form"]

  connect() {
    console.log("✅ auto-submit controller connected", this.formTarget)
  }

  submit() {
    console.log("🛫 auto-submit#submit called")
    this.formTarget.requestSubmit()
  }
}
