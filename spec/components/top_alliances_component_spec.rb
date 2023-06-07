# frozen_string_literal: true

require "rails_helper"

describe TopAlliancesComponent, type: :component do
  it { should be_an(ApplicationComponent) }

  context "when alliances is blank" do
    subject { described_class.new }

    before { render_inline(subject) }

    specify { expect(page).to have_text("Loading...") }
  end

  context "when alliances is present" do
    let(:alliances) do
      [
        build(:eve_alliance,
          id: 99_005_338,
          name: "Pandemic Horde",
          corporations_count: 12_345,
          characters_count: 12_345)
      ]
    end

    subject { described_class.new(alliances: alliances) }

    before { render_inline(subject) }

    specify { expect(page).to have_link("Pandemic Horde", href: "/universe/alliances/99005338") }

    # specify { expect(page).to have_selector("tr[id='eve_alliance_99005338']") }

    # specify { expect(page.assert_selector("tr[id='eve_alliance_99005338']")) }

    # specify { expect(page).to have_css("") }

    specify { expect(page).not_to have_text("Loading...") }
  end
end
