# frozen_string_literal: true

# rubocop:disable GraphQL/ObjectDescription
module Types
  module NodeType
    include Types::BaseInterface
    # Add the `id` field
    include GraphQL::Types::Relay::NodeBehaviors
  end
end
# rubocop:enable GraphQL/ObjectDescription
