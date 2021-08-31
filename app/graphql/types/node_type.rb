# frozen_string_literal: true

module Types
  module NodeType
    # rubocop:disable GraphQL/ObjectDescription

    include Types::BaseInterface
    # Add the `id` field
    include GraphQL::Types::Relay::NodeBehaviors
    # rubocop:enable GraphQL/ObjectDescription
  end
end
