# frozen_string_literal: true

class DecoratorExtension < GraphQL::Schema::FieldExtension
  def after_resolve(value:, **rest)
    if value.respond_to?(:decorate)
      value.decorate
    else
      value
    end
  end
end
