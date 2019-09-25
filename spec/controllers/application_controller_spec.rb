# frozen_string_literal: true

require "rails_helper"

describe ApplicationController do
  it { should be_a(Pundit) }

  it { should use_before_action(:require_login) }
end
