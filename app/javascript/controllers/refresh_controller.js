import { Controller } from "@hotwired/stimulus";
import { patch } from "@rails/request.js";

export default class extends Controller {
  static values = {
    id: Number
  }

  connect() {
    console.log("connected")
  }

  disconnect() {
    console.log("disconnect")
  }

  async update() {
    console.log("update")
    console.log(this.idValue)

    const response = await patch(`/characters/${this.idValue}`)

    if (response.ok) {
      console.log("OK")
      document.getElementById("#alerts").append("hello")
    } else {
      console.log("NOT OK")
    }
  }
}
