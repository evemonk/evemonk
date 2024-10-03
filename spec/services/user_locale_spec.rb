# frozen_string_literal: true

require "rails_helper"

RSpec.describe UserLocale do
  let(:language) { double }

  subject { described_class.new(language) }

  specify do
    expect(described_class::LOCALES).to eq(
      "english" => :en,
      "german" => :de,
      "french" => :fr,
      "japanese" => :ja,
      "korean" => :ko
    )
  end

  describe "#initialize" do
    its(:language) { is_expected.to eq(language) }
  end

  describe "#to_locale" do
    context "when language is missing" do
      let(:language) { "ukrainian" }

      specify { expect(subject.to_locale).to eq(:en) }
    end

    context "when language is present" do
      let(:language) { "japanese" }

      specify { expect(subject.to_locale).to eq(:ja) }
    end
  end
end
