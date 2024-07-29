# frozen_string_literal: true

module Imageable
  include ActiveSupport::Concern

  def imageproxy_url
    Rails.application.config.evemonk.image_proxy_url if Rails.application.config.evemonk.use_image_proxy
  end

  # https://github.com/esi/esi-docs/blob/master/docs/image_server.md
  def imageable_url(category, id, variation, size)
    "#{imageproxy_url}https://images.evetech.net/#{category}/#{id}/#{variation}?size=#{size}"
  end
end
