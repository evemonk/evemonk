# frozen_string_literal: true

require "rails_helper"

RSpec.describe CharacterNavBarComponent, type: :component do
  subject { described_class.new(character: character, current_page: :settings) }

  it { expect(subject).to be_an(ApplicationComponent) }

  before { render_inline(subject) }

  let(:character) { build_stubbed(:character) }


end
