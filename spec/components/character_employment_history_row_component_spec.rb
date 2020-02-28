# frozen_string_literal: true

require "rails_helper"

describe CharacterEmploymentHistoryRowComponent, type: :component do
  pending "add some examples to (or delete) #{__FILE__}"

  context "when corporation exists" do
    let(:eve_corporation) do
      build(:eve_corporation,
        corporation_id: 1000171,
        name: "Republic University").decorate
    end

    it "renders" do
      expect(
        render_inline(described_class, corporation: eve_corporation, start_date: Time.zone.now - 1.year).to_html
      ).to eq(
        "Hello, components!"
      )
    end
  end

  context "when corporation not exists" do

  end

  # it "renders something useful" do
  #   expect(
  #     render_inline(described_class, attr: "value") { "Hello, components!" }.css("p").to_html
  #   ).to include(
  #     "Hello, components!"
  #   )
  # end
end
