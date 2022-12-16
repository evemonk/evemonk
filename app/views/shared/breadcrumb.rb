# frozen_string_literal: true

module Views
  module Shared
    class Breadcrumb < Phlex::HTML
      # include Rails.application.routes.url_helpers

      def template
        div(class: "row") do
          div(class: "col") do
            nav(aria: {label: "breadcrumb"}) do
              ol(class: "breadcrumb") do
                yield
              end
            end
          end
        end
      end
    end
  end
end
