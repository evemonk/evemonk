# frozen_string_literal: true

module Views
  module Universe
    module Types
      class Show < Phlex::HTML
        include Rails.application.routes.url_helpers

        def initialize(type:)
          @type = type
        end

        def template
          render Views::Shared::Breadcrumb.new do
            render Views::Shared::BreadcrumbItem.new(title: "Home", to: root_path)
          end
        end
      end
    end
  end
end
