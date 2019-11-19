# frozen_string_literal: true

require "rails_helper"

describe ApplicationController do
  it { should use_before_action(:require_login) }

  # private methods

  describe "#not_authenticated" do
    before { expect(subject).to receive(:redirect_to).with(sign_in_path, alert: "Please login first") }

    specify { expect { subject.send(:not_authenticated) }.not_to raise_error }
  end
end
