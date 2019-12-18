# frozen_string_literal: true

require "rails_helper"

describe ApplicationController do
  it { should use_before_action(:authenticate_user!) }

  # private methods

  describe "#after_sign_in_path_for" do
    let(:resource) { double }

    specify { expect(subject.send(:after_sign_in_path_for, resource)).to eq("/characters") }
  end
end
