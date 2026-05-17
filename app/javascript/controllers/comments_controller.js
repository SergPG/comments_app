import { Controller } from "@hotwired/stimulus"
import { FetchRequest } from "@rails/request.js"

// Connects to data-controller="comments"
export default class extends Controller {
  static targets = ["modal", "actions"]

  connect() {
    this.activeComment = null
  }

  open(event) {
    this.activeComment = JSON.parse(event.currentTarget.dataset.comment)

    this.showModal()
  }

  showModal() {
    this.modalTarget.classList.remove("hidden")

    if (this.canModify()) {
      this.actionsTarget.classList.remove("hidden")
    } else {
      this.actionsTarget.classList.add("hidden")
    }
  }

  close() {
    this.modalTarget.classList.add("hidden")
    this.activeComment = null
  }

  edit() {
    window.dispatchEvent(new CustomEvent("comment:edit", { detail: this.activeComment }))

    this.close()
  }

  async delete() {
    if (!this.activeComment) return

    const request = new FetchRequest(
      "delete",
      `/comments/${this.activeComment.id}`,
      {
        headers: {
          Accept: "text/vnd.turbo-stream.html"
        }
      }
    )

    await request.perform()
    this.close()
  }

  canModify() {
    const currentUserId = Number(document.body.dataset.currentUserId)
    return this.activeComment?.user_id === currentUserId
  }
}
