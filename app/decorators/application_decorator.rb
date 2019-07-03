# frozen_string_literal: true

class ApplicationDecorator < Draper::Decorator
  delegate_all

  def self.collection_decorator_class
    PaginatingDecorator
  end
end
