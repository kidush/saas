Rails.configuration.stripe = {
    :public_key => ENV["STRIPE_PUBLIC"],
    :secret_key => ENV["STRIPE_SECRET"]
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]