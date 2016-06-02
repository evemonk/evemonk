module Api
  class DocsController < ActionController::Base
    include Swagger::Blocks

    # :nocov:
    swagger_root do
      key :swagger, '2.0'
      info do
        key :version, '0.1.0'
        key :title, 'EveMonk back-end API'
      end
      key :schemes, ['http']
      key :host, (ENV['API_BACKEND_HOST'] || 'localhost:3000')
      key :basePath, '/api'
      key :consumes, ['application/json']
      key :produces, ['application/json']
      tag do
        key :name, 'signups'
        key :description, 'Signups operations'
      end
      tag do
        key :name, 'sessions'
        key :description, 'Session operation'
      end
    end

    # A list of all classes that have swagger_* declarations.
    SWAGGERED_CLASSES = [
      Api::Docs::Sessions,
      Api::Docs::Signups,

      Api::Docs::Models::OutputUser,

      self
    ].freeze
    # :nocov:

    def index
      render json: Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
    end
  end
end
