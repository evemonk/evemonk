# frozen_string_literal: true

require "rails_helper"

RSpec.describe GraphqlController do
  it { is_expected.to be_an(ApplicationController) }

  it { is_expected.to_not use_before_action(:authenticate_user!) }

  describe "#execute" # TODO: write something
end
