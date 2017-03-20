class Api::V1::SwaggerController < ApplicationController
  include Swagger::Blocks

  swagger_root do
    key :swagger, '2.0'

    info do
      key :version, '1'
      key :title, 'Find-a-Home'
      key :description, 'Findahome is a platform to make locating affordable housing a cinch.'

      contact do
        key :name, 'howdoicomputer@fastmail.com'
      end

      license do
        key :name, 'GPLv3'
      end
    end

    key :host, 'findahome.family'
    key :basePath, '/api'
    key :consumes, ['application/json']
    key :produces, ['application/json']
  end

  # A list of all classes that have swagger_* declarations.
  SWAGGERED_CLASSES = [
    ListingsController,
    Listing,
    self
  ].freeze

  def index
    render json: Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
  end
end
