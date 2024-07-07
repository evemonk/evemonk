# frozen_string_literal: true

require "rails_helper"

RSpec.describe IndustryJobsController do
  it { should be_an(ApplicationController) }

  it { should use_before_action(:authenticate_user!) }

  describe "#index" do
  end
end
