module Api
  module Backoffice
    class BaseController < ApplicationController
      helper_method :parent, :collection, :resource
    
      def create
        build_resource
      
        resource.save!
      end
    
      def update
        resource.update!(resource_params)
      end
    
      def destroy
        resource.destroy!
      
        head :ok
      end
    
      # :nocov:
      rescue_from ActionController::ParameterMissing do |exception|
        @exception = exception
      
        render :exception, status: :unprocessable_entity
      end
    
      rescue_from ActiveRecord::RecordInvalid, ActiveModel::StrictValidationFailed do
        render :errors, status: :unprocessable_entity
      end
    
      rescue_from ActiveRecord::RecordNotFound do
        head :not_found
      end
    
      rescue_from ActionController::UnknownFormat do
        head :not_acceptable
      end
      # :nocov:
  
      private
  
      def parent
        raise NotImplementedError
      end
  
      def resource
        raise NotImplementedError
      end
  
      def resource_params
        raise NotImplementedError
      end
  
      def build_resource
        raise NotImplementedError
      end
  
      def collection
        raise NotImplementedError
      end
  
    end
  end
end
