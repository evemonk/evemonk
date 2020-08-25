# frozen_string_literal: true

require "rails_helper"

describe Admin::CharactersController do
  it_behaves_like "disable modification", Character

  it { should be_an(Admin::ApplicationController) }

  it { should be_an(Admin::DisableModifications) }
end
