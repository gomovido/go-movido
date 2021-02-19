class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: [:google_oauth2, :facebook]
  has_many :addresses, dependent: :destroy
  has_many :subscriptions, through: :addresses
  has_many :billings, dependent: :destroy
  has_one :person, dependent: :destroy
  accepts_nested_attributes_for :person

  extend FriendlyId
  friendly_id :username, use: :slugged
  validates_presence_of :first_name, :last_name, :email
  validates_uniqueness_of :email, :username
  validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  before_create :generate_username

  def self.from_omniauth_google(access_token)
    data = access_token['omniauth.auth']['info']
    locale = access_token['omniauth.params']['locale']
    user = User.find_by(email: data['email'])
    unless user
      user = User.create(
        email: data['email'],
        password: Devise.friendly_token[0,20],
        first_name: data['first_name'],
        last_name: data['last_name']
      )
      UserMailer.with(user: user, locale: locale).welcome_email.deliver_now
    end
    return user
  end

  def user_subscriptions_country
    self.subscriptions.where.not(state: 'aborted').select {|s| s if s.product.country == self.active_address.country }
  end

  def active_address
    Address.find_by(user: self, active: true)
  end

  def is_complete?
    !Person.find_by(user: self).nil?
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"]
      end
    end
  end

  private

  protected

  def generate_username
    self.username =  (self.first_name + '-' + self.last_name).gsub(' ', '-') + '-' + Digest::SHA1.hexdigest([Time.now, rand].join)[0..10]
    generate_username if User.exists?(username: self.username)
  end
end
