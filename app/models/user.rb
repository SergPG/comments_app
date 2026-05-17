class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :comments

  before_validation :normalize_username
  before_save :normalize_username

  validates :username, presence: true, uniqueness: true

  def normalize_username
    self.username = username.to_s.downcase.strip
  end
end
