module Api
  class ApiKeysController < BaseController
    private

    def resource_params
      params.require(:api_key).permit(:key_id, :v_code)
    end

    def build_resource
      @resource = current_user.api_keys.build(resource_params)
    end

    def resource
      @resource ||= current_user.api_keys.find(params[:id])
    end

    def collection
      current_user.api_keys.order(created_at: :asc)
    end
  end
end
