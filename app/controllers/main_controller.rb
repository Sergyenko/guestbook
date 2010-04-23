class MainController < ApplicationController

def index
 
  @messages = Message.paginate :page => params[:page], :per_page => 5, :order => 'updated_at DESC'
  #@messages = Message.all(:order => 'updated_at DESC')
  @message  = Message.new
  @rgb_colors = Message::RGB
  @smiles = Message::SMILES
  @smiles_on_main = Message::SMILES_ON_MAIN
  if session[:user_id] != nil
    @user = User.find(session[:user_id])
  end

end
def carousel
  @smiles = Message::SMILES
end

def signin
   
end

def addbbtag
  render :update do |page|
    page << "$('message_content').value += '#{params[:bbtag]}';"
  end
end

def signout
  session[:user_id] = nil
  redirect_to root_path
end

end
