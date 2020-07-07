# frozen_string_literal: true

require "rails_helper"

describe Types::BaseArgument do
  subject { described_class.new(required: nil, owner: nil) }

  it { should be_a(GraphQL::Schema::Argument) }
end
