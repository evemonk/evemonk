import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  submit_form() {
    this.element.submit();
  }
}
