class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, :confirmable and :omniauthable
  # rubocop:disable Naming/VariableNumber
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: %i[google_oauth2 facebook]

  after_create :send_welcome_email

  has_one :house, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_one :user_marketing, dependent: :destroy

  validates :first_name, :last_name, presence: true
  validates :email, uniqueness: { case_sensitive: false }

  def paid_orders?
    orders.where(state: 'succeeded').present?
  end

  def current_draft_order
    orders.find_by(state: 'pending_payment')
  end

  def send_welcome_email
    UserMailer.with(user_id: self.id, locale: 'en').welcome_email.deliver_later
  end
  # rubocop:enable Naming/VariableNumber
  # def self.from_omniauth_google(access_token)
  #   data = access_token['omniauth.auth']['info']
  #   locale = access_token['omniauth.params']['locale']
  #   user = User.find_by(email: data['email'])
  #   unless user
  #     user = User.new(
  #       email: data['email'],
  #       password: Devise.friendly_token[0, 20],
  #       first_name: data['first_name'],
  #       last_name: data['last_name']
  #     )
  #     user.skip_confirmation!
  #     user.save
  #     UserMailer.with(user: user, locale: locale).welcome_email_without_confirmation.deliver_now
  #   end
  #   return user
  # end

  # def self.new_with_session(params, session)
  #   super.tap do |user|
  #     data = session["devise.facebook_data"]
  #     user.email = data["email"] if data && session["devise.facebook_data"]["extra"]["raw_info"]
  #   end
  # end
end
