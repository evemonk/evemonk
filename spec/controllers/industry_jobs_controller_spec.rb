# frozen_string_literal: true

require "rails_helper"

RSpec.describe IndustryJobsController do
  it { is_expected.to be_an(ApplicationController) }

  it { is_expected.to use_before_action(:authenticate_user!) }

  describe "#index" do
  end
end
