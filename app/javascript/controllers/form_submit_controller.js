import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  /**
   * Submit form with form.requestSubmit().
   *
   * https://discuss.hotwired.dev/t/form-submit-with-turbo-streams-response-without-redirect/3290
   */
  submit_form() {
    this.element.requestSubmit();
  }
}
