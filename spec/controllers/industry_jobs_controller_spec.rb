# frozen_string_literal: true

require "rails_helper"

RSpec.describe IndustryJobsController, type: :controller do
  it { expect(subject).to be_an(ApplicationController) }

  it { expect(subject).to use_before_action(:authenticate_user!) }

  describe "#index" do
  end
end
