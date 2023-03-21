# frozen_string_literal: true

module Resolvers
  class Base < GraphQL::Schema::Resolver
    description "Base resolver"

    # if you have a custom argument class, you can attach it:
    argument_class Arguments::Base
  end
end
