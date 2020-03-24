# frozen_string_literal: true

require "rails_helper"

describe Universe::SearchesController do
  it { should be_a(ApplicationController) }

  it { should_not use_before_action(:authenticate_user!) }

  describe "#index" do
    # TODO: write
  end
end
