# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApplicationComponent, type: :component do
  it { expect(subject).to be_a(ViewComponent::Base) }
end
