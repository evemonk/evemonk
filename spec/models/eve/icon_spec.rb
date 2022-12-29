# frozen_string_literal: true

require "rails_helper"

describe Eve::Icon do
  it { should be_an(ApplicationRecord) }

  it { expect(described_class.primary_key).to eq("icon_id") }

  it { expect(described_class.table_name).to eq("eve_icons") }

  it { should respond_to(:versions) }

  describe "#icon_url" do
    context "when icon_file start with res:/ui/texture/icons/" do
      subject { build(:eve_icon, icon_file: "res:/ui/texture/icons/1.png") }

      specify { expect(subject.icon_url).to eq("https://static.evemonk.com/Invasion_1.0/Icons/items/1.png") }
    end

    context "when nothing found" do
      subject { build(:eve_icon, icon_file: nil) }

      specify { expect(subject.icon_url).to eq(nil) }
    end
  end
end
