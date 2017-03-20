class Api::BaseController < ActionController::Base
  class << self
    Swagger::Docs::Generator.set_real_methods

    def inherited(subclass)
      super
      subclass.class_eval do
        setup_basic_api_documentation
      end
    end

    private

    def setup_basic_api_documentation; end
  end
end
