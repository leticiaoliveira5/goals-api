class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :jwt_authenticatable,
         :registerable,
         :validatable,
         jwt_revocation_strategy: JwtDenylist

  has_many :goals, dependent: :destroy

  validates :username,
            presence: true,
            length: { maximum: 15, minimum: 3 },
            uniqueness: true
end
