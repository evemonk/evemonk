# frozen_string_literal: true

require "rails_helper"

RSpec.describe SafeEveSanitizer do
  it { expect(subject).to be_a(Rails::Html::Sanitizer) }
end
