# frozen_string_literal: true

require "rails_helper"

RSpec.describe GraphqlController do
  it { should be_an(ApplicationController) }

  it { should_not use_before_action(:authenticate_user!) }

  describe "#execute" # TODO: write something
end
