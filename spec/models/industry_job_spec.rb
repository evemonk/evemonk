# frozen_string_literal: true

require "rails_helper"

RSpec.describe IndustryJob, type: :model do
  it { expect(subject).to be_an(ApplicationRecord) }

  it { expect(subject).to belong_to(:character) }

  it { expect(subject).to belong_to(:product_type).class_name("Eve::Type").optional(true) }

  it { expect(subject).to belong_to(:blueprint_type).class_name("Eve::Type").optional(true) }
end
