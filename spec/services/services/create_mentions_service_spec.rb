require "rails_helper"

RSpec.describe Notifications::CreateMentionsService do
  describe ".call" do
    subject(:execute_service) { described_class.call(comment) }

    let!(:author) { create(:user, username: "john") }
    let!(:mentioned_user) { create(:user, username: "alice") }
    let!(:second_user) { create(:user, username: "bob") }

    context "when comment contains mentions" do
      let(:comment) do
        create(:comment, user: author, body: "Hello @alice and @bob")
      end

      it "creates notifications for mentioned users" do
        expect { execute_service }.to change(Notification, :count).by(2)

        expect(Notification.last.recipient).to eq(second_user)
      end
    end

    context "when mentioned user does not exist" do
      let(:comment) do
        create(:comment, user: author, body: "Hello @unknown_user")
      end

      it "does not create notifications" do
        expect { execute_service }.not_to change(Notification, :count)
      end
    end

    context "when user mentions themselves" do
      let(:comment) do
        create(:comment, user: author, body: "Hello @john")
      end

      it "does not create notification" do
        expect { execute_service }.not_to change(Notification, :count)
      end
    end

    context "when the same user is mentioned multiple times" do
      let(:comment) do
        create(:comment, user: author, body: "@alice hello again @alice")
      end

      it "creates only one notification" do
        expect { execute_service }.to change(Notification, :count).by(1)
      end
    end
  end
end
