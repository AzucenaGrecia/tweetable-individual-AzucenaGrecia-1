class ApplicationRecord < ActiveRecord::Base
  # self.abstract_class = true
  # protect_from_forgery with: :exception
  before_action :update_allowed_parameters, if: :devise_controller?

  protected

  def update_allowed_parameters
    permissions = Proc.new do |user|
      user.permit(:email,
                  :password,
                  :password_confirmation,
                  :current_password,
                  :name,
                  :username,
                  :avatar)
    end

    devise_parameter_sanitizer.permit(:sign_up, &permissions)
    devise_parameter_sanitizer.permit(:account_update, &permissions)
  end

end
