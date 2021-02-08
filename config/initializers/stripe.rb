if Rails.env.development?
  Rails.configuration.stripe = {
    publishable_key: Rails.application.credentials.development[:stripe][:publishable_key],
    secret_key:  Rails.application.credentials.development[:stripe][:secret_key]
  }
elsif Rails.env.staging?
  Rails.configuration.stripe = {
    publishable_key: Rails.application.credentials.staging[:stripe][:publishable_key],
    secret_key:  Rails.application.credentials.staging[:stripe][:secret_key]
  }
else
  Rails.configuration.stripe = {
    publishable_key: Rails.application.credentials.production[:stripe][:publishable_key],
    secret_key:  Rails.application.credentials.production[:stripe][:secret_key]
  }
end
Stripe.api_key = Rails.configuration.stripe[:secret_key]
