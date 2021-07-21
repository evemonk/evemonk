# frozen_string_literal: true

class SignInViaEveOnline
  include ActionView::Helpers::FormHelper
  include ActionView::Helpers::AssetTagHelper
  include ActionView::Context

  URL = "/auth/eve_online_sso"

  def form
    form_with(url: URL, method: :post, data: {turbo: false}, class: "sign_in_via_eve_online") do
      button_tag(class: "sign_in_button") do
        image_tag(image_uri, alt: "Sign in via EVE Online", class: "sign_in_image")
      end
    end
  end

  private

  def image_uri
    uri = "https://web.ccpgamescdn.com/eveonlineassets/developers/eve-sso-login-black-large.png"

    uri = "#{Setting.image_proxy_url}#{uri}" if Setting.use_image_proxy

    uri
  end
end
