import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="comment-form"
export default class extends Controller {
  static targets = [
    "form",
    "input",
    "submit",
    "editPanel",
    "editText"
  ]

  connect() {
    this.element.addEventListener("turbo:submit-end", (event) => {
      if (event.detail.success) {
        this.resetForm()
      }
    })
  }

  fill(event) {
    const comment = event.detail

    this.commentId = comment.id

    // textarea value
    this.inputTarget.value = comment.body

    // edit panel text
    this.editTextTarget.textContent = comment.body

    // show edit panel
    this.editPanelTarget.classList.remove("hidden")

    // change button text
    this.submitTarget.textContent = "Update"

    // switch form to PATCH
    this.formTarget.action = `/comments/${comment.id}`

    // Rails method spoofing
    this.setMethod("patch")

    // focus textarea
    this.inputTarget.focus()
  }

  cancelEdit() {
    this.resetForm()
  }

  resetForm() {
    // reset action
    this.formTarget.action = "/comments"

    // remove PATCH method
    this.removeMethod()

    // clear textarea
    this.inputTarget.value = ""

    // reset button
    this.submitTarget.textContent = "Send"

    // hide panel
    this.editPanelTarget.classList.add("hidden")

    this.commentId = null
  }

  setMethod(method) {
    let methodInput = this.formTarget.querySelector('input[name="_method"]')

    if (!methodInput) {
      methodInput = document.createElement("input")

      methodInput.type = "hidden"
      methodInput.name = "_method"

      this.formTarget.appendChild(methodInput)
    }

    methodInput.value = method
  }

  removeMethod() {
    const methodInput = this.formTarget.querySelector('input[name="_method"]')

    if (methodInput) {
      methodInput.remove()
    }
  }
}
