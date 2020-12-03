class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: [:google_oauth2, :facebook]
  has_many :addresses, dependent: :destroy
  has_many :subscriptions, through: :addresses
  has_many :billings, dependent: :destroy

  #accepts_nested_attributes_for :addresses, reject_if: proc { |attributes| attributes['street'].blank? }
  COUNTRIES = [:fr, :uk]

  extend FriendlyId
  friendly_id :username, use: :slugged

  validates_presence_of :first_name, :last_name, :email
  validates_presence_of :birthdate, :birth_city, :phone, on: :update
  validates_uniqueness_of :email, :username
  validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  phony_normalize :phone, default_country_code: 'FR'
  validates_plausible_phone :phone, presence: true, on: :update
  before_create :generate_username
  after_create :send_welcome_email


  def active_address
    Address.find_by(user: self, active: true)
  end

  def update_user_country
    self.update(country: self.active_address.country)
  end

  def is_complete?
    self.first_name.present? && self.last_name.present? && self.email.present? && self.birthdate.present? && self.birth_city.present?.present? && self.phone.present?
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"]
      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.first_name = auth.info.name.split(' ')[0]
      user.last_name = auth.info.name.split(' ').drop(1).join('-')
    end
  end

  def self.from_omniauth_google(access_token)
    data = access_token.info
    user = User.find_by(email: data['email'])
    unless user
        user = User.create(
           email: data['email'],
           password: Devise.friendly_token[0,20],
           first_name: data['first_name'],
           last_name: data['last_name']
        )
    end
    return user
  end

  private

  def send_welcome_email
    UserMailer.with(user: self).welcome.deliver_now
  end

  protected

  def generate_username
    self.username =  (self.first_name + '-' + self.last_name).gsub(' ', '-') + '-' + Digest::SHA1.hexdigest([Time.now, rand].join)[0..10]
    generate_username if User.exists?(username: self.username)
  end
end
