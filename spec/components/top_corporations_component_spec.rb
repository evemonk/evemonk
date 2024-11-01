# frozen_string_literal: true

require "rails_helper"

RSpec.describe TopCorporationsComponent, type: :component do
  let(:corporations) { Eve::Corporation.none }

  subject { described_class.new(corporations: corporations, lazy: true) }

  it { expect(subject).to be_an(ApplicationComponent) }

  context "when lazy is true" do
    let(:corporations) { Eve::Corporation.none }

    subject { described_class.new(corporations: corporations, lazy: true) }

    before { render_inline(subject) }

    specify { expect(page).to have_text("Loading...") }
  end

  context "when lazy is false" do
    let(:corporations) do
      [
        build(:eve_corporation,
          id: 98_258_093,
          name: "Strategic Exploration and Development Corp",
          member_count: 12_345)
      ]
    end

    subject { described_class.new(corporations: corporations, lazy: false) }

    before { render_inline(subject) }

    specify { expect(page).to have_no_text("Loading...") }

    specify { expect(page).to have_link("Strategic Exploration and Development Corp", href: "/universe/corporations/98258093") }

    specify { expect(page).to have_text("12 345") }
  end
end
