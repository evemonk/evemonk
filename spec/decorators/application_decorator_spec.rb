# frozen_string_literal: true

require 'rails_helper'

describe ApplicationDecorator do
  let(:object) { double }

  subject { described_class.new(object) }

  it { should be_a(Draper::Decorator) }

  # delegate_all
end
