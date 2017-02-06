module Api
  class SignOut
    include ActionController::HttpAuthentication::Token

    attr_reader :request

    def initialize(request)
      @request = request
    end

    def destroy!
      token, = token_and_options(request)

      session = Session.find_by!(token: token)

      session.destroy!
    end
  end
end
