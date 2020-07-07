# frozen_string_literal: true

require "rails_helper"

describe Mutations::BaseMutation do
  subject { described_class.new(object: nil, context: nil, field: nil) }

  it { should be_a(GraphQL::Schema::RelayClassicMutation) }

  it { expect(described_class.argument_class).to eq(Types::BaseArgument) }

  it { expect(described_class.field_class).to eq(Types::BaseField) }

  it { expect(described_class.input_object_class).to eq(Types::BaseInputObject) }

  it { expect(described_class.object_class).to eq(Types::BaseObject) }
end
