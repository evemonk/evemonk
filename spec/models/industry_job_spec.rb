# frozen_string_literal: true

require "rails_helper"

RSpec.describe IndustryJob do
  it { is_expected.to be_an(ApplicationRecord) }

  it { is_expected.to belong_to(:character) }

  it { is_expected.to belong_to(:product_type).class_name("Eve::Type").optional }

  it { is_expected.to belong_to(:blueprint_type).class_name("Eve::Type").optional }
end
