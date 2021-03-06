# frozen_string_literal: true

module Admin
  module DisableModifications
    extend ActiveSupport::Concern

    def valid_action?(name, resource = resource_class)
      ["create", "new", "edit", "update", "destroy"].exclude?(name.to_s) && super
    end
  end
end
