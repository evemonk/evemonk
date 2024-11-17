# frozen_string_literal: true

require "rails_helper"

RSpec.describe CharacterCardComponent, type: :component do
  let(:character) { build_stubbed(:character) }

  subject { described_class.new(character) }

  it { expect(subject).to be_an(ApplicationComponent) }
end
