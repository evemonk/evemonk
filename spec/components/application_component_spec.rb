# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApplicationComponent, type: :component do
  it { is_expected.to be_a(ViewComponent::Base) }
end
