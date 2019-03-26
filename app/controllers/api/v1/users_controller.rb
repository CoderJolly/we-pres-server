class Api::V1::UsersController < ApplicationController
    before_action :authenticate_user_custom, only: [:update_user, :sign_out, :destroy_user, :user]
    before_action :find_user_by_email, only: [:sign_in]

    def new_user
        @user = User.new(set_params)
        if @user.save
            @user.set_auth_token
            render json: { message: "User registration successful", data: @user, status: 200 }
        else
            render json: { message: "User can't be saved", status: 401 }
        end
    end

    def update_user
        if @current_user
            if @current_user.valid_password? params[:password]
                if @current_user.update(set_params)
                    render json: { message: "User updated successfully", data: @current_user, status: 200 }
                else
                    render json: { message: "User can't be updated", status: 401 }
                end
            else
                render json: { message: 'Invalid email or password', status: 401 }
            end
        else
            render json: { message: "Can't find user", status: 401 }
        end
    end

    def user
        if @current_user
            render json: { message: "User", data: @user, status: 200 }
        else
            render json: { message: "Can't find user", status: 401 }
        end
    end

    def sign_in
        if @user
            if @user.valid_password? params[:password]
                @user.set_auth_token
                render json: @user
            else
                render json: { message: 'Invalid email or password', status: 401 }
            end
        else
            render json: { message: "User doesn't exist", status: 401 }
        end
    end

    def sign_out
        if @current_user
            if @current_user.remove_auth_token
                render json: { message: 'Sign out successful', status: 200 }
            else
                render json: { message: "Can't sign out", status: 401 }
            end
        end
    end

    def destroy_user
        if @current_user
            if @current_user.valid_password? params[:password]
                if @current_user.destroy
                    render json: { message: "User deleted successfully", status: 200 }
                else
                    render json: { message: "Can't delete", status: 401 }
                end
            else
                render json: { message: 'Invalid email or password', status: 401 }
            end
        end
    end

    private
    def set_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end

    def find_user_by_email
        @user = User.find_by_email(params[:email])
    end
end