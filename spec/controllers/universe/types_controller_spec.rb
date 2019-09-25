# frozen_string_literal: true

require "rails_helper"

describe Universe::TypesController do
  it { should be_a(ApplicationController) }

  it { should_not use_before_action(:require_login) }

  describe "#index" # TODO: write

  describe "#show" # TODO: write
end
