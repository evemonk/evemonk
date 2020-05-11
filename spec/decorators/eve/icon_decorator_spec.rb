# frozen_string_literal: true

require "rails_helper"

describe Eve::IconDecorator do
  subject { described_class.new(double) }

  it { should be_an(ApplicationDecorator) }

  describe "#icon_url" do
    context "when icon_file start with res:/ui/texture/icons/" do
      let(:eve_icon) { create(:eve_icon, icon_file: "res:/ui/texture/icons/1.png") }

      subject { eve_icon.decorate }

      specify { expect(subject.icon_url).to eq("https://static.evemonk.com/Invasion_1.0/Icons/items/1.png") }
    end

    context "when nothing found" do
      let(:eve_icon) { create(:eve_icon, icon_file: nil) }

      subject { eve_icon.decorate }

      specify { expect(subject.icon_url).to eq(nil) }
    end
  end
end
