# frozen_string_literal: true

module Imageable
  include ActiveSupport::Concern

  def imageproxy_url
    Setting.image_proxy_url if Setting.use_image_proxy
  end

  # https://github.com/esi/esi-docs/blob/master/docs/image_server.md
  def imageable_url(category, id, variation, size)
    "#{imageproxy_url}https://images.evetech.net/#{category}/#{id}/#{variation}?size=#{size}"
  end
end
