# frozen_string_literal: true

require "rails_helper"

describe ApplicationComponent, type: :component do
  it { should be_a(ViewComponent::Base) }
end
