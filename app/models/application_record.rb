# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def imageproxy_url
    Setting.image_proxy_url if Setting.use_image_proxy
  end
end
