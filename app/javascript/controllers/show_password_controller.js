import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "button"];
  static values = {
    showLabel: { type: String, default: "show" },
    hideLabel: {
      type: String,
      default: "hide",
    },
  };
  toggleType(event) {
    const button = event.target;
    const buttonIndex = this.buttonTargets.findIndex((btn) => btn === button);
    const input = this.inputTargets[buttonIndex];
    const isHidden = input.type === "password";
    input.type = isHidden ? "text" : "password";
    button.textContent = isHidden ? this.hideLabelValue : this.showLabelValue;
    button.setAttribute("aria-pressed", String(isHidden));
  }
}
