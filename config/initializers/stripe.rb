Rails.configuration.stripe = {
  if Rails.env.development?
    publishable_key: Rails.application.credentials.development[:stripe][:publishable_key],
    secret_key:  Rails.application.credentials.development[:stripe][:secret_key]
  else
    publishable_key: Rails.application.credentials.production[:stripe][:publishable_key],
    secret_key:  Rails.application.credentials.production[:stripe][:secret_key]
  end
}
Stripe.api_key = Rails.configuration.stripe[:secret_key]
