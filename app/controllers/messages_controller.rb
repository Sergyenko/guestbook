class MessagesController < ApplicationController
 
  def create
   @message = Message.new(params[:message])
   if User.find_by_name(params[:name]) == nil
      params[:reg] ? (createnewuser ? postmessage : (redirect_to root_path)) : postmessage
   else
      params[:reg] ? posterror("User already exist!") : (authenticateuser ? postmessage : posterror("Wrong pass!"))
   end
  end

   def edit
     @message = Message.find(params[:id])
     @rgb_colors = Message::RGB
     @smiles = Message::SMILES
     @message.content = Message.format_return(@message.content)
     if session[:user_id]
      @user = User.find(session[:user_id])
      unless @message.user_id == @user.id || @user.group.id == 1
         posterror("You need to bee author of message or admin to edit it.")
      end
     else
      redirect_to root_path
     end
   end

   def update
    @message = Message.find(params[:id])
     params[:message][:content] = Message.safe_format(params[:message][:content])
     if @message.update_attributes(params[:message])
        redirect_to root_path
      else
        posterror("error on update!")
      end
    end

   def destroy
    @message = Message.find(params[:id])
      if @message.destroy
        redirect_to root_path
      end
   end

private

    def createnewuser
      user = User.new(:name => params[:name],:group_id => '2')

      if user.save
        password  = Password.new(:user_id => user.id, :hashed_password => params[:password])
        passport  = Passport.new(:user_id => user.id)
        avatar    = Avatar.new(:user_id => user.id)
        if password.save && avatar.save && passport.save
        else
          user.destroy
          flash[:errors] = "Errors on creation"
          return false
        end
      else
          flash[:errors] = user.errors.on(:name).to_s
          return false
      end
      return true
    end

    def authenticateuser
      if session[:user_id]
        password = User.find(session[:user_id]).password.hashed_password
      else
        password = params[:password]
      end
      Password.authenticate(params[:name], password) ? (return true) : (return false)
    end

    def postmessage
       user = User.find_by_name(params[:name])
       if user
         session[:user_id] = user.id
         @message.user_id = user.id
         @message.user_name = user.name
         @message.user_message_number = user.messages.size
         @message.user_register_date = user.created_at
         @message.user_group = user.group.name
         @message.user_avatar = (user.avatar.url == nil ? '' : user.avatar.url)
         @message.content = Message.safe_format(params[:message][:content])
       else
         session[:user_id] = nil
         @message.user_name = params[:name].to_s
         @message.content = Message.safe_format(params[:message][:content])
       end
       if @message.save
          redirect_to root_path
       else
         flash[:errors] = @message.errors.on(:user_name).to_s
         redirect_to root_path
       end
    end

    def posterror(error)
      flash[:errors] = error.to_s
      redirect_to root_path
    end
end
