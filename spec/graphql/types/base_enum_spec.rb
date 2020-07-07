# frozen_string_literal: true

require "rails_helper"

describe Types::BaseEnum do
  it { should be_a(GraphQL::Schema::Enum) }
end
