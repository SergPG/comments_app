module Notifications
  class CreateMentionsService
    MENTION_REGEX = /(?<=\s|^)@([a-zA-Z0-9_]+)/

    def self.call(comment)
      new(comment).call
    end

    def initialize(comment)
      @comment = comment
    end

    def call
      mentioned_users.each do |user|
        create_notification(user)
      end
    end

    private

    attr_reader :comment

    def mentioned_usernames
      comment.body.scan(MENTION_REGEX).flatten.map(&:downcase).uniq
    end

    def mentioned_users
      User.where(username: mentioned_usernames)
    end

    def create_notification(user)
      return if user == comment.user

      Notification.create!(
        recipient: user,
        actor: comment.user,
        notifiable: comment
      )
    end
  end
end
