require 'RMagick'

class UsersController < ApplicationController
  
  before_filter :authorize, :except => [:index, :show]

  def index
    @users = User.all
    if session[:user_id] != nil
      @user = User.find(session[:user_id])
    end
  end

  def show
     @user = User.find(params[:id])
  end

  def edit
    
  end

  def update
    @user = User.find(params[:id])
    @passport = Passport.find_by_user_id(params[:id])
    
    if @user.update_attributes(params[:user])
         if !params[:password].empty?
           password = Password.find_by_user_id(params[:id])
           password.hashed_password = params[:password]
            if password.save
            else
              posterror("error on update!")
            end
          end

         if !params[:avatar].empty?
           if params[:avatar].to_s.scan('radikal.ru/').size > 0
             img =  Magick::Image.read(params[:avatar]).first
             
             if img.columns.to_i <= 100 && img.rows.to_i <= 300
               avatar = Avatar.find_by_user_id(params[:id])
               avatar.url = params[:avatar]
               if avatar.save
                  else
                  posterror("error on update!")
                end
             else
                
                 flash[:errors] = "Available resolution x <= 100, y <= 300. Your image resolution: " + img.columns.to_s + "x" + img.rows.to_s
             end
           else
             
             flash[:errors] = "Use <a href='http://www.radikal.ru/'>www.radikal.ru</a> to upload your avatars"
           end
         end

         if @passport.update_attributes(params[:passport])
           
         end

        redirect_to edit_user_path(@user)
      else
        posterror("error on update!")
      end
  end

  def destroy
    @user = User.find(params[:id])
    @password = Password.find_by_user_id(params[:id])
    if session[:user_id] == @user.id
      posterror("Currently login!")
    else
      if @user.destroy && @password.destroy
        redirect_to users_path
      end
    end
  end

  private
   def posterror(error)
      flash[:errors] = error.to_s
      redirect_to root_path
    end
end
