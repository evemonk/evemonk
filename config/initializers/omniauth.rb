Rails.application.config.middleware.use OmniAuth::Builder do
  provider :eve_online_sso, ENV['EVE_ONLINE_SSO_CLIENT_ID'], ENV['EVE_ONLINE_SSO_SECRET_KEY'], scope: 'publicData'
end
