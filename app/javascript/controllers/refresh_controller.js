import { Controller } from "@hotwired/stimulus";
import { patch } from "@rails/request.js";

export default class extends Controller {
  static values = {
    url: String,
  };

  connect() {
    console.log("connected");
  }

  disconnect() {
    console.log("disconnected");
  }

  async update() {
    console.log("update");
    console.log(this.urlValue);

    const response = await patch(this.urlValue);

    if (response.ok) {
      console.log("OK");
      // document.getElementById("#alerts").append("hello");
    } else {
      console.log("NOT OK");
    }
  }
}
