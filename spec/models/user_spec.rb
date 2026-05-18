require "rails_helper"

RSpec.describe User, type: :model do
  subject { build(:user, username: "john") }

  describe "validations" do
    it { should validate_presence_of(:username) }

    it { should validate_uniqueness_of(:username).case_insensitive }
  end

  describe "associations" do
    it { should have_many(:comments) }

    it { should have_many(:received_notifications).class_name("Notification").with_foreign_key("recipient_id") }

    it { should have_many(:sent_notifications).class_name("Notification").with_foreign_key("actor_id") }
  end

  describe "#normalize_username" do
    it "downcases and strips username" do
      user = build(:user, username: "  JohnDOE  ")

      user.valid?

      expect(user.username).to eq("johndoe")
    end
  end
end
