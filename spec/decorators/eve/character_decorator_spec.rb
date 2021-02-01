# frozen_string_literal: true

require "rails_helper"

describe Eve::CharacterDecorator do
  subject { described_class.new(double) }

  it { should be_an(ApplicationDecorator) }

  describe "#birthday" do
    context "when birthday is present" do
      let(:eve_character) do
        build(:eve_character,
          birthday: "Sun, 03 May 2015 19:45:17 UTC +00:00")
      end

      subject { eve_character.decorate }

      specify { expect(subject.birthday).to eq("2015-05-03T19:45:17Z") }
    end

    context "when birthday is empty" do
      let(:eve_character) { build(:eve_character, birthday: nil) }

      subject { eve_character.decorate }

      specify { expect(subject.birthday).to eq(nil) }
    end
  end

  describe "#description" do
    let(:eve_character) do
      build(:eve_character,
        description: "<b>Test</b>")
    end

    subject { eve_character.decorate }

    specify { expect(subject.description).to eq("Test") }
  end

  describe "#security_status" do
    let(:eve_character) do
      build(:eve_character,
        security_status: 1.1234)
    end

    subject { eve_character.decorate }

    specify { expect(subject.security_status).to eq("1.1") }
  end
end
