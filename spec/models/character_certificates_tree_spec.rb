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
        #           .where(group_id: group_ids)
        #           .order(:name_en)
        #           .to_a # => groups
        #
        expect(Eve::Group).to receive(:published) do
          double.tap do |a|
            expect(a).to receive(:where).with(group_id: group_ids) do
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

  # def certificates_in_group(group_id)
  #   certificates.select { |certificate| certificate.group_id == group_id }.sort_by(&:name)
  # end

  # private methods

  describe "#group_ids" do
    let!(:eve_certificate1) { create(:eve_certificate, group_id: 1) }

    let!(:eve_certificate2) { create(:eve_certificate, group_id: 2) }

    let!(:eve_certificate3) { create(:eve_certificate, group_id: 3) }

    let!(:eve_certificate4) { create(:eve_certificate, group_id: 3) }

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
