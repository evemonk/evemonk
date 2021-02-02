# frozen_string_literal: true

require "rails_helper"

describe CharacterDecorator do
  xdescribe "#birthday" do
    context "when birthday is present" do
      let(:character) do
        build(:character,
          birthday: "Sun, 03 May 2015 19:45:17 UTC +00:00")
      end

      subject { character.decorate }

      specify { expect(subject.birthday).to eq("2015-05-03T19:45:17Z") }
    end

    context "when birthday is empty" do
      let(:character) { build(:character, birthday: nil) }

      subject { character.decorate }

      specify { expect(subject.birthday).to eq(nil) }
    end
  end

  xdescribe "#security_status" do
    context "when security status is missing" do
      let(:character) do
        build(:character,
          security_status: nil)
      end

      subject { character.decorate }

      specify { expect(subject.security_status).to eq(nil) }
    end

    context "when security status is present" do
      let(:character) do
        build(:character,
          security_status: 1.1234)
      end

      subject { character.decorate }

      specify { expect(subject.security_status).to eq("1.1") }
    end
  end

  xdescribe "#wallet" do
    let(:character) do
      build(:character,
        wallet: 8252.49)
    end

    subject { character.decorate }

    specify { expect(subject.wallet).to eq(8252) }
  end
end
