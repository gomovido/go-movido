class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # rubocop:disable Naming/VariableNumber
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: %i[google_oauth2 facebook]
  has_many :addresses, dependent: :destroy
  has_many :subscriptions, through: :addresses
  has_many :billings, dependent: :destroy
  has_one :person, dependent: :destroy
  accepts_nested_attributes_for :person

  extend FriendlyId
  friendly_id :username, use: :slugged
  validates :first_name, :last_name, :email, presence: true
  validates :email, :username, uniqueness: true
  validates :email, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }
  before_create :generate_username
  # rubocop:enable Naming/VariableNumber
  def self.from_omniauth_google(access_token)
    data = access_token['omniauth.auth']['info']
    locale = access_token['omniauth.params']['locale']
    user = User.find_by(email: data['email'])
    unless user
      user = User.create(
        email: data['email'],
        password: Devise.friendly_token[0, 20],
        first_name: data['first_name'],
        last_name: data['last_name']
      )
      UserMailer.with(user: user, locale: locale).welcome_email.deliver_now
    end
    return user
  end

  def user_subscriptions_country
    subscriptions.where.not(state: 'aborted').select { |s| s if s.product.country == active_address.country }
  end

  def active_address
    Address.find_by(user: self, active: true)
  end

  def complete?
    !Person.find_by(user: self).nil? && !Person.find_by(user: self).birthdate.nil? && !Person.find_by(user: self).birth_city.nil? && !Person.find_by(user: self).phone.nil?
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      data = session["devise.facebook_data"]
      user.email = data["email"] if data && session["devise.facebook_data"]["extra"]["raw_info"]
    end
  end

  protected

  def generate_username
    self.username = "#{"#{first_name}-#{last_name}".tr(' ', '-')}-#{Digest::SHA1.hexdigest([Time.zone.now, rand].join)[0..10]}"
    generate_username if User.exists?(username: username)
  end
end
