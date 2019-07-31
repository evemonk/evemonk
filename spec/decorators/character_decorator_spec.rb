# frozen_string_literal: true

require "rails_helper"

describe CharacterDecorator do
  subject { described_class.new(double) }

  it { should be_a(ApplicationDecorator) }

  describe "#birthday" do
    let(:character) do
      build(:character,
            birthday: "Sun, 03 May 2015 19:45:17 UTC +00:00")
    end

    subject { character.decorate }

    specify { expect(subject.birthday).to eq("2015-05-03T19:45:17Z") }
  end

  describe "#icon" do
    let(:character) do
      build(:character,
            character_id: 123)
    end

    subject { character.decorate }

    specify { expect(subject.icon).to eq("https://imageserver.eveonline.com/Character/123_512.jpg") }
  end

  describe "#description" do
    let(:character) do
      build(:character,
            description: "<b>Test</b>")
    end

    subject { character.decorate }

    specify { expect(subject.description).to eq("Test") }
  end

  describe "#security_status" do
    let(:character) do
      build(:character,
            security_status: 1.1)
    end

    subject { character.decorate }

    specify { expect(subject.security_status).to eq("1.1") }
  end

  describe "#last_remap_date" do
    let(:character) do
      build(:character,
            last_remap_date: "Sun, 03 May 2015 19:45:17 UTC +00:00")
    end

    subject { character.decorate }

    specify { expect(subject.last_remap_date).to eq("2015-05-03T19:45:17Z") }
  end

  describe "#accrued_remap_cooldown_date" do
    let(:character) do
      build(:character,
            accrued_remap_cooldown_date: "Sun, 03 May 2015 19:45:17 UTC +00:00")
    end

    subject { character.decorate }

    specify { expect(subject.accrued_remap_cooldown_date).to eq("2015-05-03T19:45:17Z") }
  end

  describe "#wallet" do
    let(:character) do
      build(:character,
            wallet: 8252.49)
    end

    subject { character.decorate }

    specify { expect(subject.wallet).to eq("8252.49 ISK") }
  end
end
