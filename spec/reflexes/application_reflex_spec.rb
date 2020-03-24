# frozen_string_literal: true

require "rails_helper"

describe ApplicationReflex do
  subject { described_class.new(double) }

  it { should be_a(StimulusReflex::Reflex) }

  it { should delegate_method(:current_user).to(:connection) }
end
