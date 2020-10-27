class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :addresses, dependent: :destroy
  has_many :subscriptions, through: :addresses

  accepts_nested_attributes_for :addresses, reject_if: proc { |attributes| attributes['street'].blank? }


  extend FriendlyId
  friendly_id :username, use: :slugged

  validates_presence_of :first_name, :last_name, :email, :phone, :city, :username
  validates_uniqueness_of :email, :username
  phony_normalize :phone, default_country_code: 'FR'
  validates_plausible_phone :phone, presence: true
  validates :moving_date, presence: true, if: -> { :alread_moved == false }
  #after_create :send_welcome_email

  private


  def send_welcome_email
    UserMailer.with(user: self).welcome.deliver_now
  end
end
