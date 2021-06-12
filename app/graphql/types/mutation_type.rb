# frozen_string_literal: true

# TODO: remove this
module Types
  class MutationType < Types::BaseObject
    description "Mutations"

    # TODO: remove me
    field :test_field, String, null: false,
                               description: "An example field added by the generator"
    def test_field
      "Hello World"
    end
  end
end
