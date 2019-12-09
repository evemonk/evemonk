# frozen_string_literal: true

module ApplicationHelper
  def sign_in_via_eve_online
    link_to(image_tag("#{ Setting.image_proxy_url if Setting.use_image_proxy }https://web.ccpgamescdn.com/eveonlineassets/developers/eve-sso-login-black-large.png",
                      alt: "Sign in via EVE Online"),
            "/auth/eve_online_sso")
  end
end
