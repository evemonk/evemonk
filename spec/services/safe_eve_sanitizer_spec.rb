# frozen_string_literal: true

require "rails_helper"

describe SafeEveSanitizer do
  it { should be_a(Rails::Html::Sanitizer) }
end
