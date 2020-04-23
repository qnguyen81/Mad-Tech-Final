# frozen_string_literal: true

# Rails.configuration.stripe = {
#   publishable_key: ENV['PUBLISHABLE_KEY'],
#   secret_key: ENV['SECRET_KEY']
# }

# Stripe.api_key = Rails.configuration.stripe[:secret_key]

Rails.configuration.stripe = {
  publishable_key: ENV['pk_test_hnRNkJwJxwIZ0Ln4WMAOCcJz00ZrCq78li'],
  secret_key: ENV['sk_test_eZT4YztklI9vKCUL3O1yITg800r5FGUxG4']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
# PUBLISHABLE_KEY = pk_test_hnRNkJwJxwIZ0Ln4WMAOCcJz00ZrCq78li SECRET_KEY= sk_test_eZT4YztklI9vKCUL3O1yITg800r5FGUxG4
