import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "preview"];

  connect() {
    this.preview();
  }

  preview() {
    const content = this.inputTarget.value || "";

    if (content.trim() === "") {
      this.previewTarget.innerHTML =
        '<p class="text-gray-400">Preview will appear here...</p>';
      return;
    }

    // Show loading state
    this.previewTarget.innerHTML =
      '<p class="text-gray-400">Loading preview...</p>';

    fetch("/api/markdown/preview", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]')
          .content,
      },
      body: JSON.stringify({ content }),
    })
      .then((response) => {
        if (!response.ok) throw new Error("Network response was not ok");
        return response.text();
      })
      .then((html) => {
        this.previewTarget.innerHTML = html;
      })
      .catch((error) => {
        console.error("Error:", error);
        this.previewTarget.innerHTML =
          '<p class="text-red-400">Error loading preview. Please try again.</p>';
      });
  }
}
