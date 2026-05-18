import { Controller } from "@hotwired/stimulus"
import { FetchRequest } from "@rails/request.js"

// Connects to data-controller="comments"
export default class extends Controller {
  static targets = ["modal", "actions", "forbiddenMessage"]

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
      this.forbiddenMessageTarget.classList.add("hidden")
    } else {
      this.actionsTarget.classList.add("hidden")
      this.forbiddenMessageTarget.classList.remove("hidden")
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
    const meta = document.querySelector("meta[name='current-user-id']")
    const currentUserId = Number(meta?.content)

    const commentUserId = Number(this.activeComment?.user_id)

    return currentUserId && commentUserId && currentUserId === commentUserId
  }
}
