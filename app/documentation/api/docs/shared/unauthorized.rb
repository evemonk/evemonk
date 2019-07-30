# frozen_string_literal: true

# :nocov:
module Api
  module Docs
    module Shared
      module Unauthorized
        def self.extended(base)
          base.response "401" do
            key :description, "Unauthorized"
          end
        end
      end
    end
  end
end
# :nocov:
