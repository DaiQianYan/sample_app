class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # Including the Sessions helper module into the Application controller.
  include SessionsHelper

  # 13.32 Moving the logged_in_user method into the Application controller.
  private
  
      # Confirms a logged-in user.
      def logged_in_user
        unless logged_in?
          store_location
          flash[:danger] = "Please log in."
          redirect_to login_url
        end
      end
      
end
