class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # Including the Sessions helper module into the Application controller.
  include SessionsHelper
end
