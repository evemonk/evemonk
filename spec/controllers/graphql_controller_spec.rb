# frozen_string_literal: true

require "rails_helper"

RSpec.describe GraphqlController do
  it { expect(subject).to be_an(ApplicationController) }

  it { expect(subject).not_to use_before_action(:authenticate_user!) }

  describe "#execute" # TODO: write something
end
