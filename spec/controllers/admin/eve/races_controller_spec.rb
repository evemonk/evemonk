# frozen_string_literal: true

require "rails_helper"

describe Admin::Eve::RacesController do
  it_behaves_like "disable modification", Eve::Race

  it { should be_an(Admin::ApplicationController) }

  it { should be_an(Admin::DisableModifications) }
end
