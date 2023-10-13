import { Application } from "@hotwired/stimulus";
import PasswordVisibility from "stimulus-password-visibility";
import Autocomplete from "stimulus-autocomplete";

const application = Application.start();
application.register("password-visibility", PasswordVisibility);
application.register("autocomplete", Autocomplete);

// Configure Stimulus development experience
application.debug = false;
window.Stimulus = application;

export { application };
