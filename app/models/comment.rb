class Comment < ApplicationRecord
  include Meilisearch::Rails

  belongs_to :user

  validates :body, presence: true

  after_create_commit :create_mentions_notifications

  meilisearch do
    attribute :body
    attribute :created_at

    searchable_attributes [ :body ]
    sortable_attributes [ :created_at ]
  end

  private

  def create_mentions_notifications
    Notifications::CreateMentionsService.call(self)
  end
end
