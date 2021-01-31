# frozen_string_literal: true

module ImageProxy
  include ActiveSupport::Concern

  def imageproxy_url
    Setting.image_proxy_url if Setting.use_image_proxy
  end
end
