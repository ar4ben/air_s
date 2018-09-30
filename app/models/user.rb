class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :confirmable, :omniauthable, omniauth_providers: [:google_oauth2]

  validates :fullname, presence: true, length: {maximum: 50}

  has_many :rooms

  has_many :guest_reviews, class_name: "GuestReview", foreign_key: "guest_id"
  has_many :host_reviews, class_name: "HostReview", foreign_key: "host_id"

  def self.from_omniauth(auth)
    data = auth.info

    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
       user.email = data['email']
       user.password = Devise.friendly_token[0,20]
       user.fullname = "#{data["first_name"]} #{data["last_name"]}"
       user.image = data['image']
       user.skip_confirmation!
    end
  end
end
