# frozen_string_literal: true

require "rails_helper"

RSpec.describe Universe::SearchController do
  it { is_expected.to be_a(ApplicationController) }

  it { is_expected.to_not use_before_action(:authenticate_user!) }

  describe "#index" do
    # TODO: write
  end
end
