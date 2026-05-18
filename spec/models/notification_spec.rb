require "rails_helper"

RSpec.describe Notification, type: :model do
  describe "associations" do
    it { should belong_to(:recipient).class_name("User") }
    it { should belong_to(:actor).class_name("User") }
    it { should belong_to(:notifiable) }
  end

  describe "scope :unread" do
    let(:user) { create(:user, username: "john") }

    it "returns notifications without read_at" do
      unread = create(:notification, recipient: user, actor: user, notifiable: create(:comment))
      read = create(:notification, :read, recipient: user, actor: user, notifiable: create(:comment))

      expect(Notification.unread).to include(unread)
      expect(Notification.unread).not_to include(read)
    end
  end

  describe "#read?" do
    it "returns true when read_at is present" do
      notification = build(:notification, read_at: Time.current)
      expect(notification.read?).to eq(true)
    end

    it "returns false when read_at is nil" do
      notification = build(:notification, read_at: nil)
      expect(notification.read?).to eq(false)
    end
  end

  describe "#mark_as_read!" do
    it "sets read_at timestamp" do
      notification = create(:notification, read_at: nil)

      notification.mark_as_read!

      expect(notification.read_at).to be_present
    end
  end
end
