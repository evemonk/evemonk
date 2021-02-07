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

  describe "#groups" do
    context "when @groups not set" do
      let(:group_ids) { double }

      before { expect(subject).to receive(:group_ids).and_return(group_ids) }

      let(:groups) { double }

      before do
        #
        # Eve::Group.published
        #           .where(group_id: group_ids)
        #           .order(:name_en) # => groups
        #
        expect(Eve::Group).to receive(:published) do
          double.tap do |a|
            expect(a).to receive(:where).with(group_id: group_ids) do
              double.tap do |b|
                expect(b).to receive(:order).with(:name_en).and_return(groups)
              end
            end
          end
        end
      end

      specify { expect { subject.groups }.not_to raise_error }

      specify { expect { subject.groups }.to change { subject.instance_variable_get(:@groups) }.from(nil).to(groups) }
    end

    context "when @groups is set" do
      let(:groups) { double }

      before { subject.instance_variable_set(:@groups, groups) }

      specify { expect(subject.groups).to eq(groups) }
    end
  end

  describe "#certificates_in_group" do
    let!(:eve_group1) { create(:eve_group) }

    let!(:eve_group2) { create(:eve_group) }

    let!(:eve_certificate1) { create(:eve_certificate, group_id: eve_group1.group_id) }

    let!(:eve_certificate2) { create(:eve_certificate, group_id: eve_group1.group_id) }

    let!(:eve_certificate3) { create(:eve_certificate, group_id: eve_group2.group_id) }

    specify { expect(subject.certificates_in_group(eve_group1.group_id).size).to eq(2) }

    specify { expect(subject.certificates_in_group(eve_group1.group_id)).to include(eve_certificate1) }

    specify { expect(subject.certificates_in_group(eve_group1.group_id)).to include(eve_certificate2) }

    specify { expect(subject.certificates_in_group(eve_group2.group_id).size).to eq(1) }

    specify { expect(subject.certificates_in_group(eve_group2.group_id)).to include(eve_certificate3) }
  end
end
