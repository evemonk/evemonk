# frozen_string_literal: true

require "rails_helper"

describe Admin::ApplicationController do
  it { should be_an(Administrate::ApplicationController) }

  it { should use_before_action(:authenticate_user!) }

  it { should use_before_action(:admin?) }

  # private methods

  describe "#admin?" do
    before { expect(subject).to receive(:current_user).and_return(user) }

    context "when current user admin" do
      let(:user) { build(:user, admin: true) }

      before { expect(subject).not_to receive(:redirect_to) }

      specify { expect(subject.send(:admin?)).to eq(nil) }
    end

    context "when current user not admin" do
      let(:user) { build(:user, admin: false) }

      let(:root_url) { double }

      before { expect(subject).to receive(:root_url).and_return(root_url) }

      before { expect(subject).to receive(:redirect_to).with(root_url) }

      specify { expect { subject.send(:admin?) }.not_to raise_error }
    end
  end

  describe "#default_sorting_attribute" do
    specify { expect(subject.send(:default_sorting_attribute)).to eq(:id) }
  end

  describe "#default_sorting_direction" do
    specify { expect(subject.send(:default_sorting_direction)).to eq(:asc) }
  end
end
