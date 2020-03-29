# frozen_string_literal: true

require "rails_helper"

describe ApplicationController do
  it { should use_before_action(:authenticate_user!) }

  it { should use_before_action(:default_locale) }

  it { should use_before_action(:current_user_locale) }

  # private methods

  describe "#after_sign_in_path_for" do
    let(:resource) { double }

    specify { expect(subject.send(:after_sign_in_path_for, resource)).to eq("/characters") }
  end

  describe "#default_locale" do
    before { expect(I18n).to receive(:locale=).with(:en) }

    specify { expect { subject.send(:default_locale) }.not_to raise_error }
  end
end
