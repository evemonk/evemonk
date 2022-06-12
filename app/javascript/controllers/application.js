import { Application } from "@hotwired/stimulus";
import PasswordVisibility from "stimulus-password-visibility";

const application = Application.start();
application.register("password-visibility", PasswordVisibility);

// Configure Stimulus development experience
application.debug = false;
window.Stimulus = application;

export { application };
