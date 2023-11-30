class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.from_google_payload(payload)
    where(email: payload['email']).first_or_create do |user|
      user.email = payload['email']
      user.password = Devise.friendly_token[0, 20] if user.password.blank?
    end
  end
end
