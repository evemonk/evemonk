import { Controller } from "@hotwired/stimulus";
import "ninja-keys";

export default class extends Controller {
  connect() {
    this.element.data = [
      {
        id: "home",
        title: "Home",
        mdIcon: "home",
        hotkey: "H",
        handler: () => {
          Turbo.visit("/");
        },
      },
      {
        id: "characters",
        title: "My Characters",
        mdIcon: "groups_2",
        hotkey: "M",
        handler: () => {
          Turbo.visit("/characters");
        },
      },
    ];
  }
}
