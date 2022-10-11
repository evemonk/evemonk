import { Controller } from "@hotwired/stimulus";

/**
 * This is Stimulus controller for formatting time from seconds to human time.
 *
 * Example:
 *
 *   <div data-controller="human-time" data-time="12000">
 *     <span data-human-time-target="time">3h 20m</span>
 *   </div>
 */
export default class extends Controller {
  static targets = ["time"];

  /**
   * Function that called when controller are connected to element.
   */
  connect() {
    const value = this.element.dataset.time;

    this.format(value);
  }

  /**
   * Function to explicitly refresh displayed formatted human time.
   * @param content Time in seconds
   */
  refresh({ detail: { content } }) {
    this.format(content);
  }

  /**
   * Function to format time in seconds to human time.
   * @param value Time in seconds
   */
  format(value) {
    const SECONDS_IN_DAY = 24 * 60 * 60;
    const SECONDS_IN_HOUR = 60 * 60;
    const SECONDS_IN_MINUTE = 60;

    let seconds = parseInt(value, 10);

    const days = parseInt(seconds / SECONDS_IN_DAY, 10);

    if (days > 0) {
      seconds = seconds % SECONDS_IN_DAY;
    }

    const hours = parseInt(seconds / SECONDS_IN_HOUR, 10);

    if (hours > 0) {
      seconds = seconds % SECONDS_IN_HOUR;
    }

    const minutes = parseInt(seconds / SECONDS_IN_MINUTE, 10);

    if (minutes > 0) {
      seconds = seconds % SECONDS_IN_MINUTE;
    }

    let output = "";

    if (days > 0) {
      output += `${days}d `;
    }

    if (hours > 0) {
      output += `${hours}h `;
    }

    if (minutes > 0) {
      output += `${minutes}m `;
    }

    if (seconds > 0) {
      output += `${seconds}s `;
    }

    this.timeTarget.innerText = output;
  }
}
