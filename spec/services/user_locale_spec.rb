# frozen_string_literal: true

require "rails_helper"

describe UserLocale do
  let(:language) { double }

  subject { described_class.new(language) }

  specify { expect(described_class::LOCALES).to eq("english" => :en,
                                                   "german" => :de,
                                                   "french" => :fr,
                                                   "japanese" => :ja,
                                                   "russian" => :ru,
                                                   "chinese" => :zh,
                                                   "korean" => :ko) }

  describe "#initialize" do
    its(:language) { should eq(language) }
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
