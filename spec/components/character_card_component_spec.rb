# frozen_string_literal: true

require "rails_helper"

RSpec.describe CharacterCardComponent, type: :component do
  let(:eve_race) { create(:eve_race, name_en: "Minmatar") }

  let(:eve_bloodline) { create(:eve_bloodline, name_en: "Brutor") }

  let(:character) do
    create(:character,
      gender: "male",
      race: eve_race,
      bloodline: eve_bloodline)
  end

  subject { described_class.new(character) }

  it { expect(subject).to be_an(ApplicationComponent) }

  context "when full card" do
    subject { described_class.new(character, full: true) }

    before { render_inline(subject) }

    # TODO: Corporation
    # TODO: Alliance

    specify { expect(page).to have_content("Minmatar / Brutor") }

    specify { expect(page).to have_content("Gender: male") }

    # specify { expect(page).to have_text("Loading...") }
    # specify { expect(page).to have_text("Loading...") }
    # specify { expect(page).to have_text("Loading...") }
    # specify { expect(page).to have_text("Loading...") }
    # specify { expect(page).to have_text("Loading...") }
  end

  context "when not full card" do
    subject { described_class.new(character, full: false) }

    before { render_inline(subject) }

    specify { expect(page).to have_no_content("Minmatar / Brutor") }

    specify { expect(page).to have_no_content("Gender: male") }
  end
end
