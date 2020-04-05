# frozen_string_literal: true

require "rails_helper"

describe Eve::BlueprintDecorator do
  subject { described_class.new(double) }

  it { should be_a(Eve::TypeDecorator) }

  describe "#copying_time_formatted" do
    let(:eve_blueprint) { Eve::Blueprint.new(attributes_for(:eve_type, copying_time: 240)) }

    subject { eve_blueprint.decorate }

    before do
      #
      # HumanTime.new(copying_time).long_formatted
      #
      expect(HumanTime).to receive(:new).with(240) do
        double.tap do |a|
          expect(a).to receive(:long_formatted)
        end
      end
    end

    specify { expect { subject.copying_time_formatted }.not_to raise_error }
  end
end
