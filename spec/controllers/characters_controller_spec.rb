# frozen_string_literal: true

require "rails_helper"

describe CharactersController do
  it { should be_a(ApplicationController) }

  it { should use_before_action(:require_login) }

  describe "#index"

  describe "#show"

  describe "#destroy"
end
