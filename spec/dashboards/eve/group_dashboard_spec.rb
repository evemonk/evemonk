# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::GroupDashboard do
  it { is_expected.to be_an(Administrate::BaseDashboard) }

  describe "#display_resource" do
    let(:group) { build(:eve_group, name_en: "Missiles") }

    specify { expect(subject.display_resource(group)).to eq("Missiles") }
  end
end
