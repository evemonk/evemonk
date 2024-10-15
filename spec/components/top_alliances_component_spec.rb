# frozen_string_literal: true

require "rails_helper"

RSpec.describe TopAlliancesComponent, type: :component do
  it { expect(subject).to be_an(ApplicationComponent) }

  context "when alliances is blank" do
    subject { described_class.new }

    before { render_inline(subject) }

    specify { expect(page).to have_text("Loading...") }
  end
end
