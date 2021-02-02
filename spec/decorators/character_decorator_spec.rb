# frozen_string_literal: true

require "rails_helper"

describe CharacterDecorator do
  xdescribe "#wallet" do
    let(:character) do
      build(:character,
        wallet: 8252.49)
    end

    subject { character.decorate }

    specify { expect(subject.wallet).to eq(8252) }
  end
end
