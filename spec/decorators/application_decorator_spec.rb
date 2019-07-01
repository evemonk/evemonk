# frozen_string_literal: true

require 'rails_helper'

describe ApplicationDecorator do
  subject { described_class.new(double) }

  it { should be_a(Draper::Decorator) }
end
