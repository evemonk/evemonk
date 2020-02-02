# frozen_string_literal: true

require "rails_helper"

describe SkillqueuesController do
  it { should be_a(ApplicationController) }

  it { should use_before_action(:authenticate_user!) }

  # TODO: describe "#index"
end
