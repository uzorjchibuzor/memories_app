import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  show(event) {
    let showPasswordButton = event.srcElement;
    let inputId = showPasswordButton.previousElementSibling.id;
    let passwordField = document.getElementById(inputId);

    if (passwordField.type === "password") {
      console.log(passwordField.type);
      passwordField.type = "text";
      showPasswordButton.innerHTML = "Hide Password";
    } else {
      passwordField.type = "password";
      showPasswordButton.innerHTML = "Show Password";
    }
  }
}
