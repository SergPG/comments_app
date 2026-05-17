class Comment < ApplicationRecord
  belongs_to :user

  validates :body, presence: true

  after_create_commit :create_mentions_notifications

  private

  def create_mentions_notifications
    Notifications::CreateMentionsService.call(self)
  end
end
