# frozen_string_literal: true

module Types
  class BaseField < GraphQL::Schema::Field
    argument_class Types::BaseArgument

    def initialize(*args, **kwargs, &block)
      kwargs[:extensions] = [DecoratorExtension]
      super(*args, **kwargs, &block)
    end
  end
end
