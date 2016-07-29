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
      @resource ||= ApiKey.find(params[:id])
    end

    def collection
      @api_keys ||= policy_scope(ApiKey).order(created_at: :asc).page(params[:page])
    end
  end
end
