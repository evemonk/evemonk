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
      let(:skills_category) { double }

      before { expect(subject).to receive(:skills_category).and_return(skills_category) }

      let(:groups) { double }

      before do
        #
        # skills_category.groups
        #                .published
        #                .includes(:types)
        #                .order(:name_en)
        #                .decorate
        #
        expect(skills_category).to receive(:groups) do
          double.tap do |a|
            expect(a).to receive(:published) do
              double.tap do |b|
                expect(b).to receive(:includes).with(:types) do
                  double.tap do |c|
                    expect(c).to receive(:order).with(:name_en) do
                      double.tap do |d|
                        expect(d).to receive(:decorate).and_return(groups)
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

  # private methods

  describe "#skills_category" do
    context "when @skills_category not set" do
      let(:skills_category) { double }

      before do
        #
        # Eve::Category.published
        #              .find_by!(category_id: SKILLS_CATEGORY_ID)
        #
        expect(Eve::Category).to receive(:published) do
          double.tap do |a|
            expect(a).to receive(:find_by!).with(category_id: described_class::SKILLS_CATEGORY_ID)
              .and_return(skills_category)
          end
        end
      end

      specify { expect { subject.send(:skills_category) }.not_to raise_error }

      specify { expect { subject.send(:skills_category) }.to change { subject.instance_variable_get(:@skills_category) }.from(nil).to(skills_category) }
    end

    context "when @skills_category is set" do
      let(:skills_category) { double }

      before { subject.instance_variable_set(:@skills_category, skills_category) }

      specify { expect(subject.send(:skills_category)).to eq(skills_category) }
    end
  end
end
