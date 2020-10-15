class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :addresses, dependent: :destroy
  has_many :subscriptions, through: :addresses

  validates_presence_of :first_name, :last_name, :email, :phone, :city
  validates_uniqueness_of :email
  phony_normalize :phone, default_country_code: 'FR'
  validates_plausible_phone :phone, presence: true
  validates :housed, presence: true, unless: :address
  validates :address, presence: true, unless: { housed: false }
  validates :already_moved, presence: true, unless: :moving_date
  validates :moving_date, presence: true, unless: :already_moved

end
