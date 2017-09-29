module Auth
  module EveOnlineSso
    class CallbacksController < ApplicationController
      def show
        binding.pry

        request.env['omniauth.auth']


        request.cookies['help'] = 'yes'
        
        puts "hello"
        
        redirect_to root_url
      end
    end
  end
end
