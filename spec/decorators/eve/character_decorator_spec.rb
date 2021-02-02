# frozen_string_literal: true

require "rails_helper"

describe Eve::CharacterDecorator do
  xdescribe "#security_status" do
    let(:eve_character) do
      build(:eve_character,
        security_status: 1.1234)
    end

    subject { eve_character.decorate }

    specify { expect(subject.security_status).to eq("1.1") }
  end
end
