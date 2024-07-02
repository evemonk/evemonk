# frozen_string_literal: true

require "rails_helper"

RSpec.describe Universe::SearchController do
  it { should be_a(ApplicationController) }

  it { should_not use_before_action(:authenticate_user!) }

  describe "#index" do
    # TODO: write
  end
end
