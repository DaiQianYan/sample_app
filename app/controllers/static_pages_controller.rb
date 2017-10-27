class StaticPagesController < ApplicationController
  def home
    # 13.40 Adding a micropost instance variable to the home action.
    @micropost = current_user.microposts.build if logged_in?
  end

  def help
  end

  def about
  end

  def contact
  end
end
