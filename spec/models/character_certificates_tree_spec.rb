# frozen_string_literal: true

require "rails_helper"

describe CharacterCertificatesTree do
  let(:character) { instance_double(Character) }

  subject { described_class.new(character) }

  describe "#initialize" do
    its(:character) { should eq(character) }
  end

  describe "#preload" do
    specify { expect(subject.preload).to eq(subject) }
  end
end
