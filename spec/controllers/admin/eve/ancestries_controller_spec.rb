# frozen_string_literal: true

require "rails_helper"

describe Admin::Eve::AncestriesController do
  it_behaves_like "disable modification", Eve::Ancestry

  it { should be_an(Admin::ApplicationController) }

  it { should be_an(Admin::DisableModifications) }
end
