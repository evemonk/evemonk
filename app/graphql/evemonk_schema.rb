# frozen_string_literal: true

class EvemonkSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)

  use Yabeda::GraphQL

  default_max_page_size 50
end
