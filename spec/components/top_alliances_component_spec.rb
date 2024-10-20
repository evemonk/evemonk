# frozen_string_literal: true

require "rails_helper"

RSpec.describe TopAlliancesComponent, type: :component do
  it { expect(subject).to be_an(ApplicationComponent) }

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
          corporations_count: 1_001,
          characters_count: 2_002)
      ]
    end

    subject { described_class.new(alliances) }

    before { render_inline(subject) }

    specify { expect(page).to have_no_text("Loading...") }

    specify { expect(page).to have_link("Pandemic Horde", href: "/universe/alliances/99005338") }

    specify { expect(page).to have_text("1 001") }

    specify { expect(page).to have_text("2 002") }
  end
end
