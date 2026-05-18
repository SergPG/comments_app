class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :comments

  has_many :received_notifications, class_name: "Notification",
           foreign_key: :recipient_id, dependent: :destroy

  has_many :sent_notifications, class_name: "Notification",
           foreign_key: :actor_id, dependent: :destroy

  before_validation :normalize_username

  validates :username, presence: true, uniqueness: true

  def normalize_username
    self.username = username.to_s.downcase.strip
  end
end
