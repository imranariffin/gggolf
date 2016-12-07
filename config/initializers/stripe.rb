Rails.configuration.stripe = {
  :publishable_key => 'pk_test_hfqesLoils75VUv75UCWGtAM',
  :secret_key      => 'sk_test_YpKrQFdTgbYFiFXvMVJHIGlF'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
