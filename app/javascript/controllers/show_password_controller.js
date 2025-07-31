import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  show() {
  let showPasswordButton = document.getElementById('show-password');
  let passwordField = document.getElementById('password-field');

  showPasswordButton.addEventListener("click", function() {
  console.log('Click')
    if (passwordField.type === 'password') {
      passwordField.type = 'text'
      showPasswordButton.textContent = 'Hide Password'
    } else {
     passwordField.type = 'password'
      showPasswordButton.textContent = 'Show Password'
   }
  });
  }
  }