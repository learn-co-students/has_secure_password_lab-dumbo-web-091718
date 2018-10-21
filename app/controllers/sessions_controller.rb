class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(name: params[:user][:name])
    user = user.try(:authenticate, params[:user][:password])
    # byebug
    if user
      session[:user_id] = user.id
      @user = user
      return redirect_to controller: 'welcome', action: 'show'
    else
      return redirect_to controller: 'sessions', action: 'new'
    end
  end

  def destroy
    session.delete :user_id
    redirect_to '/login'
  end
end
