# frozen_string_literal: true

require "rails_helper"

describe CharacterCertificatesTree do
  let(:character) { instance_double(Character) }

  subject { described_class.new(character) }

  describe "#initialize" do
    its(:character) { should eq(character) }
  end

  describe "#preload" do
    before { expect(subject).to receive(:groups) }

    before { expect(subject).to receive(:certificates) }

    specify { expect(subject.preload).to eq(subject) }
  end

  describe "#groups" do
    context "when @groups is set" do
      let(:groups) { double }

      before { subject.instance_variable_set(:@groups, groups) }

      specify { expect(subject.groups).to eq(groups) }
    end

    context "when @groups not set" do
      let(:group_ids) { double }

      before { expect(subject).to receive(:group_ids).and_return(group_ids) }

      let(:groups) { double }

      before do
        #
        # Eve::Group.published
        #           .where(id: group_ids)
        #           .order(:name_en)
        #           .to_a # => groups
        #
        expect(Eve::Group).to receive(:published) do
          double.tap do |a|
            expect(a).to receive(:where).with(id: group_ids) do
              double.tap do |b|
                expect(b).to receive(:order).with(:name_en) do
                  double.tap do |c|
                    expect(c).to receive(:to_a).and_return(groups)
                  end
                end
              end
            end
          end
        end
      end

      specify { expect { subject.groups }.not_to raise_error }

      specify { expect { subject.groups }.to change { subject.instance_variable_get(:@groups) }.from(nil).to(groups) }
    end
  end

  describe "#certificates_in_group" do
    let(:certificate_1) { instance_double(Eve::Certificate, name: "B", group_id: 1) }

    let(:certificate_2) { instance_double(Eve::Certificate, name: "A", group_id: 1) }

    let(:certificate_3) { instance_double(Eve::Certificate, name: "A", group_id: 2) }

    let(:certificates) { [certificate_1, certificate_2, certificate_3] }

    before { expect(subject).to receive(:certificates).and_return(certificates) }

    specify { expect(subject.certificates_in_group(1)).to eq([certificate_2, certificate_1]) }
  end

  # private methods

  describe "#group_ids" do
    let!(:eve_certificate_1) { create(:eve_certificate, group_id: 1) }

    let!(:eve_certificate_2) { create(:eve_certificate, group_id: 2) }

    let!(:eve_certificate_3) { create(:eve_certificate, group_id: 3) }

    let!(:eve_certificate_4) { create(:eve_certificate, group_id: 3) }

    specify { expect(subject.send(:group_ids)).to eq([1, 2, 3]) }
  end

  describe "#certificates" do
    context "when @certificates is set" do
      let(:certificates) { double }

      before { subject.instance_variable_set(:@certificates, certificates) }

      specify { expect(subject.send(:certificates)).to eq(certificates) }
    end

    context "when @certificates not set" do
      let(:certificates) { double }

      before do
        #
        # Eve::Certificate.all.to_a
        #
        expect(Eve::Certificate).to receive(:all) do
          double.tap do |a|
            expect(a).to receive(:to_a).and_return(certificates)
          end
        end
      end

      specify { expect { subject.send(:certificates) }.not_to raise_error }

      specify { expect { subject.send(:certificates) }.to change { subject.instance_variable_get(:@certificates) }.from(nil).to(certificates) }
    end
  end
end
