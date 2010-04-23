class CommentsController < ApplicationController
  
  before_filter :find_message

 
  def new
    @comment = Comment.new
    if session[:user_id] != nil
      @user = User.find(session[:user_id])
    end
  end

  def edit
    @comment = @message.comments.find(params[:id])
     if session[:user_id]
      @user = User.find(session[:user_id])
      unless @comment.user_id == @user.id || @user.group.id == 1
        redirect_to root_path
      end
     else
      redirect_to root_path
     end
  end

  def create
    @comment = Comment.new(params[:comment])
    if User.find_by_name(params[:name]) == nil
      @comment.user_name = params[:name]
      @message.updated_at = @comment.updated_at
      postcomment
    else
       @comment.user_id = User.find_by_name(params[:name]).id
       @comment.user_name = params[:name]
       @message.updated_at = @comment.updated_at
       postcomment
    end
  end

  def update
    @comment = @message.comments.find(params[:id])
    @message.updated_at = @comment.updated_at
    if (@comment.update_attributes(params[:comment]) && @message.save)
      redirect_to root_path
    else
      render :action => :edit
    end
  end

  def destroy
    comment = @message.comments.find(params[:id].to_i)
    @message.comments.destroy(comment)
    redirect_to root_path
  end

private

  def find_message
    @message_id = params[:message_id]
    redirect_to messages_url unless @message_id
    @message = Message.find(@message_id)
  end

  def postcomment
     if (@message.comments << @comment && @message.save)
        redirect_to root_path
       end
  end

 end
