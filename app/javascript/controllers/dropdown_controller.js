import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
	static targets = ["menu"]

	connect() {
		this.open = false
	}

	toggle() {
		this.open = !this.open
		this.menuTarget.classList.toggle("hidden", !this.open)
	}

	close(event) {
		if (event.target.closest("[data-dropdown-ignore]")) return
		if (this.element.contains(event.target)) return

		this.open = false
		this.menuTarget.classList.add("hidden")
	}
}
