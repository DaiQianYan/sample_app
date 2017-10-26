class MicropostsController < ApplicationController
    # # 13.34 Adding authorization to the Microposts controller actions.
    # before_action :logged_in_user, only: [:create, :destroy]
    
    # def create
    # end

    # def destroy
    # end

    # 13.36 The Microposts controller create action.
    before_action :logged_in_user, only: [:create, :destroy]
    
    def create
        @micropost = current_user.microposts.build(micropost_params)
        if @micropost.save
            flash[:success] = "Micropost created!"
            redirect_to root_url
        else
            render 'static_pages/home'
        end
    end

    def destroy
    end

    private

        def micropost_params
            params.require(:micropost).permit(:content)
        end
    
end
