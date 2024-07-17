# frozen_string_literal: true

require "rails_helper"

RSpec.describe CharacterImplant do
  it { is_expected.to be_an(ApplicationRecord) }

  it { is_expected.to belong_to(:character) }

  it { is_expected.to belong_to(:implant).class_name("Eve::Implant").with_foreign_key("type_id").optional }
end
