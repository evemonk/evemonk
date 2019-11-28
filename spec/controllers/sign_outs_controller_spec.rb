# frozen_string_literal: true

require "rails_helper"

describe SignOutsController do
  it { should be_a(ApplicationController) }

  it { should use_before_action(:require_login) }

  describe "#destroy" do
    before { sign_in }

    before { expect(subject).to receive(:logout) }

    before { delete :destroy }

    it { should redirect_to(root_path) }

    it { should set_flash[:notice].to("Logged out!") }
  end
end
