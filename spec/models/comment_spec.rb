require "rails_helper"

RSpec.describe Comment, type: :model do
  describe "validations" do
    it { should validate_presence_of(:body) }
  end

  describe "associations" do
    it { should belong_to(:user) }
  end

  describe "after_create_commit :create_mentions_notifications" do
    let(:author) { create(:user, username: "john") }

    it "calls CreateMentionsService after comment creation" do
      expect(Notifications::CreateMentionsService).to receive(:call).with(instance_of(Comment))

      create(:comment, user: author, body: "Hello @alice")
    end
  end
end
