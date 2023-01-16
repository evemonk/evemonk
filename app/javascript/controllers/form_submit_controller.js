import { Controller } from "@hotwired/stimulus";

/**
 * This is Stimulus controller to submit form in Turbo-compatible way.
 *
 * Example:
 *
 *   <form data-controller="form-submit">
 *     <select data-action="form-submit#submit_form" name="filter" id="filter">
 *       <option value="0">All</option>
 *     </select>
 *   </form>
 */
export default class extends Controller {
  /**
   * Submit form with form.requestSubmit(). So, Turbo can intercept.
   *
   * https://discuss.hotwired.dev/t/form-submit-with-turbo-streams-response-without-redirect/3290
   */
  submit_form() {
    this.element.requestSubmit();
  }
}
