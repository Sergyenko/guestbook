# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  private
  def authorize
    if session[:user_id]
      @currentuser = User.find(session[:user_id])
      @user = User.find(params[:id])
      unless @currentuser.group.id == 1 || @currentuser == @user
       redirect_to user_path(@user)
      end
    else
       @user = User.find(params[:id])
       redirect_to user_path(@user)
    end
    
  end
end
