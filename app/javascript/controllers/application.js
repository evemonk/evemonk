import { Application } from "@hotwired/stimulus";
import PasswordVisibility from "stimulus-password-visibility";

const application = Application.start();

// register third party stimulus controllers
application.register("password-visibility", PasswordVisibility);

// Configure Stimulus development experience
application.debug = false;
window.Stimulus = application;

export { application };
