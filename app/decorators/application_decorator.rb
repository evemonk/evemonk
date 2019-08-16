# frozen_string_literal: true

class ApplicationDecorator < Draper::Decorator
  delegate_all

  def imageproxy_url
    "https://imageproxy.evemonk.com/" if ENV["IMAGEPROXY_ENABLED"]
  end

  def self.collection_decorator_class
    PaginatingDecorator
  end
end
