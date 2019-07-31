# frozen_string_literal: true

require "rails_helper"

describe ApplicationDecorator do
  subject { described_class.new(double) }

  it { should be_a(Draper::Decorator) }

  describe ".collection_decorator_class" do
    specify { expect(described_class.collection_decorator_class).to eq(PaginatingDecorator) }
  end
end
