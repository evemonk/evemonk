# frozen_string_literal: true

# :nocov:
module Api
  module Docs
    module Shared
      module Forbidden
        def self.extended(base)
          base.response "403" do
            key :description, "The server understood the request but refuses to authorize it."
          end
        end
      end
    end
  end
end
# :nocov:
