Rails.configuration.stripe = {
  publishable_key: Rails.application.credentials.development[:stripe][:publishable_key],
  secret_key:  Rails.application.credentials.development[:stripe][:secret_key]
}
Stripe.api_key = Rails.configuration.stripe[:secret_key]
