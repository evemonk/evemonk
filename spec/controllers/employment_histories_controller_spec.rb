# frozen_string_literal: true

require "rails_helper"

describe EmploymentHistoriesController do
  it { should be_a(ApplicationController) }

  it { should use_before_action(:require_login) }

  describe "#index"
end
