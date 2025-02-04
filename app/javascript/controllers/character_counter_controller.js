import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "counter"];
  static values = {
    max: Number,
  };

  connect() {
    this.updateCounter();
  }

  updateCounter() {
    const currentLength = this.inputTarget.value.length;
    const remaining = this.maxValue - currentLength;
    this.counterTarget.textContent = `${remaining} characters remaining`;

    if (remaining < 0) {
      this.counterTarget.classList.add("text-red-500");
    } else {
      this.counterTarget.classList.remove("text-red-500");
    }
  }
}
