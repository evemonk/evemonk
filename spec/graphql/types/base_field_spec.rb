# frozen_string_literal: true

require "rails_helper"

describe Types::BaseField do
  subject { described_class.new(name: :id, type: Integer, null: true) }

  it { should be_a(GraphQL::Schema::Field) }

  it { expect(described_class.argument_class).to eq(Types::BaseArgument) }
end
