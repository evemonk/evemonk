# frozen_string_literal: true

require "rails_helper"

describe CertificatesTree do
  let(:character) { instance_double(Character) }

  subject { described_class.new(character) }

  describe "#initialize" do
    its(:character) { should eq(character) }
  end

  describe "#group_ids" do
    let!(:eve_certificate1) { create(:eve_certificate, group_id: 1) }

    let!(:eve_certificate2) { create(:eve_certificate, group_id: 2) }

    let!(:eve_certificate3) { create(:eve_certificate, group_id: 3) }

    let!(:eve_certificate4) { create(:eve_certificate, group_id: 3) }

    specify { expect(subject.group_ids).to eq([1, 2, 3]) }
  end
end
