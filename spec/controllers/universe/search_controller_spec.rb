# frozen_string_literal: true

require "rails_helper"

RSpec.describe Universe::SearchController do
  it { expect(subject).to be_a(ApplicationController) }

  it { expect(subject).not_to use_before_action(:authenticate_user!) }

  describe "#index" do
    # TODO: write
  end
end
