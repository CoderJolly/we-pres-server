class ApplicationController < ActionController::Base
    skip_before_action :verify_authenticity_token  

    def authenticate_user_custom
        if user_signed_in?
            @current_user = current_user
        else
            authenticate_with_http_token do |token, options|
                @current_user = User.find_by(auth_token: token)
            end
        end
  
        if @current_user.blank?
            return render json: {message: 'Unauthorized', status: 401}
        else
            return @current_user
        end
    end
end
