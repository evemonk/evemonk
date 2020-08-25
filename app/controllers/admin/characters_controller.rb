# frozen_string_literal: true

module Admin
  class CharactersController < Admin::ApplicationController
    include DisableModifications
  end
end
