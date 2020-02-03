# frozen_string_literal: true

require "rails_helper"

describe SkillsTree do
  specify { expect(described_class::SKILLS_CATEGORY_ID).to eq(16) }

  let(:character) { instance_double(Character) }

  subject { described_class.new(character) }

  describe "#initialize" do
    its(:character) { should eq(character) }
  end

  describe "#groups" do
    context "when @groups not set" do
      let(:groups) { double }

      before do
        #
        # Eve::Category.find_by!(category_id: SKILLS_CATEGORY_ID)
        #              .groups
        #              .includes(:types)
        #              .where(published: true)
        #              .order(:name_en)
        #              .decorate
        #
        expect(Eve::Category).to receive(:find_by!).with(category_id: described_class::SKILLS_CATEGORY_ID) do
          double.tap do |a|
            expect(a).to receive(:groups) do
              double.tap do |b|
                expect(b).to receive(:includes).with(:types) do
                  double.tap do |c|
                    expect(c).to receive(:where).with(published: true) do
                      double.tap do |d|
                        expect(d).to receive(:order).with(:name_en) do
                          double.tap do |e|
                            expect(e).to receive(:decorate).and_return(groups)
                          end
                        end
                      end
                    end
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

    context "when @groups is set" do
      let(:groups) { double }

      before { subject.instance_variable_set(:@groups, groups) }

      specify { expect(subject.groups).to eq(groups) }
    end
  end
end
