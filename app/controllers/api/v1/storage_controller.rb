class Api::V1::StorageController < ApplicationController
    before_action :authenticate_user_custom

    def index
        @data = nil
        if @current_user.is_admin
            @data = 'This is admin user 🌚'
        else
            @data = 'This is normal user 🤷🏻‍♂️'
        end
        render json: { message: 'Yay!', data: @data, status: 200 }
    end
end
