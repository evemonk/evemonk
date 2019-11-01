# frozen_string_literal: true

class ApplicationDecorator < Draper::Decorator
  delegate_all

  def imageproxy_url
    Setting.image_proxy_url if Setting.use_image_proxy
  end

  def self.collection_decorator_class
    PaginatingDecorator
  end
end
